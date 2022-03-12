//
//  MovieDetailVC.swift
//  TenTwentyTask
//
//  Created by usama on 12/03/2022.
//

import UIKit

protocol MovieInjector {
    func inject(viewModel: MovieDetailViewModel)
}

class MovieDetailVC: UIViewController {
    
    
    
    @IBOutlet weak var art: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieDescription: UITextView!
    @IBOutlet weak var populairtySeekBar: UIProgressView!
    @IBOutlet weak var ratingsSeekBar: UIProgressView!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var releaseYearLabel: UILabel!
    @IBOutlet weak var votesCountLabel: UILabel!
    
    var movieDetailVM: MovieDetailViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchMovieDetail()
    }
}


extension MovieDetailVC {
    func setupUI() {
        
    }
    
    func fetchMovieDetail() {
        showLoader()
        movieDetailVM.fetchMovieDetail { [weak self] errorMessage, error in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.dismissLoader()
                if let error = error {
                    self.presentAlert(Constants.failure, error)
                }
                
                if let errorMessage = errorMessage {
                    self.presentAlert(Constants.failure, nil, errorMessage)
                }
            }
        }
    }
    
    func updateUI() {
        if let movieDetial = movieDetailVM.movieDetail {
            
        }
    }
}

extension MovieDetailVC: MovieInjector {
    func inject(viewModel: MovieDetailViewModel) {
        movieDetailVM = viewModel
    }
}
