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
    
    // MARK: IBOutlets
    @IBOutlet weak var art: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var tagLine: UILabel!
    @IBOutlet weak var movieDescription: UITextView!
    @IBOutlet weak var populairtySeekBar: UIProgressView!
    @IBOutlet weak var ratingsSeekBar: UIProgressView!
    @IBOutlet weak var language: UILabel!
    @IBOutlet weak var releaseYear: UILabel!
    @IBOutlet weak var votes: UILabel!
    
    var movieDetailVM: MovieDetailViewModel!
    private var bookMarkBarButton: UIBarButtonItem!


    // MARK: UI Controller Life Cycle
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


private extension MovieDetailVC {
    func setupUI() {
        title = movieDetailVM.movie.title
        movieTitle.font = UIFont(defaultFontStyle: .bold, size: 23.0)
        tagLine.font = UIFont(defaultFontStyle: .medium, size: 14.0)
        movieDescription.font = UIFont(defaultFontStyle: .regular, size: 13.0)

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
            releaseYear.text =  movieDetial.releaseDate?.date(formatter: .apiFormatt)?.toString(formatter: .yearOnly) ?? "--"
            language.text = movieDetial.language.language
            votes.text = "\(movieDetial.voteAverage)"

            populairtySeekBar.progress = Float(movieDetial.popularity ?? 0)
            ratingsSeekBar.progress = Float(movieDetial.voteAverage ?? 0)
            
            
            if let posterPath = movieDetial.posterPath {
                
                ImageProvider.getImage(urlString: Constants.imageUrlString(iconCode: posterPath)) { [unowned self] image, error in
                    
                    if let image = image {
                        self.art.image = image
                    }
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
