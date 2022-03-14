//
//  ViewController.swift
//  TenTwentyTask
//
//  Created by usama on 09/03/2022.
//

import UIKit

class UpcomingMoviesVC: BaseTableVC {
    
    private var searchBarButton: UIBarButtonItem!
    private var viewModel: MovieListViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        getMovies()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailController = segue.destination as? MovieInjector, let movie = sender as? Movie {
            detailController.inject(viewModel: MovieDetailViewModel(movie: movie))
        }
        
        if let searchController = segue.destination as? SearchInjector, let movies = sender as? [Movie] {
            searchController.inject(viewModel: SearchViewModel(movies: movies))
        }
    }
}

extension UpcomingMoviesVC {
    
    func setupUI() {
        viewModel = MovieListViewModel()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerNib(cell: MoviesCell.self)
        addSearchBarButton()
    }
    
    func getMovies() {
        showLoader()
        viewModel.fetchUpcomingMovies { [weak self] errorMessage, error in
            
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.dismissLoader()
                if let error = error {
                    self.presentAlert(Constants.failure, error)
                }
                
                if let errorMessage = errorMessage {
                    self.presentAlert(Constants.failure, nil, errorMessage)
                }
                
                self.viewModel.upcomingMovies.count > 0 ? self.updateUI() : ()
            }
        }
    }
    
    func updateUI() {
        tableView.reloadData()
        if viewModel.upcomingMovies.count > 0 {
            searchBarButton.isHidden = false
        }
    }
    
    func addSearchBarButton() {
        searchBarButton  = UIBarButtonItem(image: UIImage(named: "searchIcon"),
                                         style: .plain,
                                         target: self,
                                         action: #selector(searchButtonTapped))
        
        navigationItem.rightBarButtonItem = searchBarButton
        searchBarButton.isHidden = true
    }

    
    @objc func searchButtonTapped(notificationBtn: UIBarButtonItem) {
        performSegue(withIdentifier: SearchVC.storyboardIdentifier, sender: viewModel.upcomingMovies)
    }
}

extension UpcomingMoviesVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.upcomingMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MoviesCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        cell.movie = viewModel.upcomingMovies[indexPath.row]
        return cell
    }
}


extension UpcomingMoviesVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: MovieDetailVC.storyboardIdentifier, sender: viewModel.upcomingMovies[indexPath.row])
    }
}
