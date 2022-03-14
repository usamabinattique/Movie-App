//
//  MoviesCell.swift
//  TenTwentyTask
//
//  Created by usama on 12/03/2022.
//

import UIKit

class MoviesCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var releaseYear: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var language: UILabel!
    @IBOutlet weak var adultLabel: UILabel!
    @IBOutlet weak var adult: UILabel!
    @IBOutlet weak var movieDescription: UITextView!
    @IBOutlet weak var icon: UIImageView!

    var movie: Movie! {
        didSet {
            
            title.text = movie.title
            releaseYear.text = movie.releaseDate.date(formatter: .apiFormatt)?.toString(formatter: .yearOnly) ?? "--"
            movieDescription.text = movie.overview
            language.text = movie.language.language
            adult.text = movie.adult ? "R" : "PG"
            
            if let posterPath = movie.posterPath {
                ImageProvider.getImage(urlString: Constants.imageUrlString(iconCode: posterPath)) { [unowned self] image, error in
                    
                    if let image = image {
                        self.icon.image = image
                    }
                }
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    func setupUI() {
        backgroundColor = Colors.theme
        title.font = UIFont(defaultFontStyle: .bold, size: 18.0)
        movieDescription.font = UIFont(defaultFontStyle: .regular, size: 12.0)
        releaseYear.font = UIFont(defaultFontStyle: .medium, size: 15.0)
        languageLabel.font = UIFont(defaultFontStyle: .regular, size: 14.0)
        language.font = UIFont(defaultFontStyle: .medium, size: 15.0)
        adultLabel.font = UIFont(defaultFontStyle: .regular, size: 14.0)
        adult.font = UIFont(defaultFontStyle: .medium, size: 15.0)
        
        
        adultLabel.textColor = .lightGray
        languageLabel.textColor = .lightGray

    }
}
