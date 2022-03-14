//
//  BookingImageCell.swift
//  TenTwentyTask
//
//  Created by usama on 14/03/2022.
//

import UIKit

class BookingImageCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    
    var seat: Seating! {
        didSet {
            imageView.isHidden = !seat.isSelected
            backgroundColor = seat.isSelected ? UIColor.systemYellow : .clear
            isHidden = seat.isCenter
            layer.borderWidth = seat.isSelected ? 0 : 2
        }
    }
}
