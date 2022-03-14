//
//  UIFont.swift
//  QCSM4
//
//  Created by Yasir Basharat on 24/03/2019.
//  Copyright © 2019 Yasir Basharat. All rights reserved.
//

import UIKit

extension UIFont {

	private enum FontSize {
        static let size: CGFloat = 13.0
	}

    convenience init(defaultFontStyle: DefaultFontStyle = .regular, textStyle: UIFont.TextStyle = UIFont.TextStyle.headline, size: CGFloat = FontSize.size) {

        let customFont = UIFont(name: defaultFontStyle.fontName, size: size)!
        let font = UIFontMetrics(forTextStyle: textStyle).scaledFont(for: customFont, maximumPointSize: 34.0)

        self.init(descriptor: font.fontDescriptor, size: 0)
    }

	enum DefaultFontStyle: String {
		case regular
		case light
		case boldItalic
		case thin
		case mediumItalic
		case medium
        case semibold
        case heavy
        case demiBold
        case semiboldItalic
		case bold
		case blackItalic
		case italic
		case thinItalic

		var fontName: String {
			return "AvenirNext-\(self.rawValue.capitalized)"
		}
	}

	static func + (left: UIFont, right: CGFloat) -> UIFont {
		return left.withSize(left.pointSize + right)
	}

	static func - (left: UIFont, right: CGFloat) -> UIFont {
		return left.withSize(left.pointSize - right)
	}

}
