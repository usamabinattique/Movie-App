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
    @IBOutlet weak var description: UITextView!
    @IBOutlet weak var icon: UIImageView!

    
    var movie: Movie! {
        didSet {
            title.text = movie.title
            releaseYear.text = movie.releaseDate
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
