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
    @IBOutlet weak var tagLine: UILabel!
    @IBOutlet weak var movieDescription: UITextView!
    @IBOutlet weak var populairtySeekBar: UIProgressView!
    @IBOutlet weak var ratingsSeekBar: UIProgressView!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var releaseYearLabel: UILabel!
    @IBOutlet weak var votesCountLabel: UILabel!
    
    var movieDetailVM: MovieDetailViewModel!
    private var bookMarkBarButton: UIBarButtonItem!


    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchMovieDetail()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let bookingController = segue.destination as? BookingInjector, let movie = sender as? Movie {
            bookingController.inject(viewModel: BookingViewModel(movie: movie))
        }
    }
}


extension MovieDetailVC {
    func setupUI() {
        title = movieDetailVM.movie.title
        movieTitle.font = UIFont(defaultFontStyle: .bold, size: 23.0)
        tagLine.font = UIFont(defaultFontStyle: .regular, size: 14.0)
        movieDescription.font = UIFont(defaultFontStyle: .regular, size: 12.0)

        addBookMarkButton()
    }
    
    func addBookMarkButton() {
        bookMarkBarButton  = UIBarButtonItem(image: UIImage(named: "booking"),
                                         style: .plain,
                                         target: self,
                                         action: #selector(bookMarkBarButtonTapped))
        
        navigationItem.rightBarButtonItem = bookMarkBarButton
    }

    
    @objc func bookMarkBarButtonTapped(bookMarkButton: UIBarButtonItem) {
        performSegue(withIdentifier: BookingVC.storyboardIdentifier, sender: movieDetailVM.movie)
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
                
                self.updateUI()
            }
        }
    }
    
    func updateUI() {
        if let movieDetial = movieDetailVM.movieDetail {
            
            movieTitle.text = movieDetial.title
            tagLine.text = movieDetial.tagline
            movieDescription.text = movieDetial.overview
            
            populairtySeekBar.progress = Float(movieDetial.popularity)
            ratingsSeekBar.progress = Float(movieDetial.voteAverage)
            
            ImageProvider.getImage(urlString: Constants.imageUrlString(iconCode: movieDetial.posterPath)) { [unowned self] image, error in
                
                if let image = image {
                    self.art.image = image
                }
            }
        }
    }
}

extension MovieDetailVC: MovieInjector {
    func inject(viewModel: MovieDetailViewModel) {
        movieDetailVM = viewModel
    }
}
