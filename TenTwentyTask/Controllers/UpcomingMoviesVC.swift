//
//  ViewController.swift
//  TenTwentyTask
//
//  Created by usama on 09/03/2022.
//

import UIKit

class UpcomingMoviesVC: BaseVC {

    @IBOutlet weak var tableView: UITableView!
    
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
    }
}

extension UpcomingMoviesVC {
    
    func setupUI() {
        viewModel = MovieListViewModel()
        tableView.estimatedRowHeight = 80.0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = .clear
        tableView.tableFooterView =  UIView()
        tableView.dataSource = self
        tableView.registerNib(cell: MoviesCell.self)
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
                
                self.viewModel.upcomingMovies.count > 0 ? self.tableView.reloadData() : ()
            }
        }
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
