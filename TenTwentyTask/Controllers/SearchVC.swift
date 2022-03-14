//
//  SearchVC.swift
//  TenTwentyTask
//
//  Created by usama on 12/03/2022.
//

import UIKit

protocol SearchInjector {
    func inject(viewModel: SearchViewModel)
}

class SearchVC: BaseTableVC {

    @IBOutlet weak var searchBar: UISearchBar!
    
    var searchVM: SearchViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailController = segue.destination as? MovieInjector, let movie = sender as? Movie {
            detailController.inject(viewModel: MovieDetailViewModel(movie: movie))
        }
    }
}

extension SearchVC {
    func setupUI() {
        tableView.registerNib(cell: MoviesCell.self)
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        searchBar.barTintColor = Colors.theme
        searchBar.searchTextField.textColor = .white

    }
}

/// UITableView Data Source
extension SearchVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchVM.filteredMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MoviesCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        cell.movie = searchVM.filteredMovies[indexPath.row]
        return cell
    }
}

/// UITableView Delegate
extension SearchVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: MovieDetailVC.storyboardIdentifier, sender: searchVM.filteredMovies[indexPath.row])
    }
}


extension SearchVC: SearchInjector {
    func inject(viewModel: SearchViewModel) {
        searchVM = viewModel
    }
}

extension SearchVC: UISearchBarDelegate {

    fileprivate func searchAlgorithm(searchText: String? = nil) {

        guard let searchText = searchText, searchText.count > 0 else {
            searchVM.filteredMovies = []
            tableView.reloadData()
            return
        }

        searchVM.filteredMovies = searchVM.allMovies.filter({ $0.title.lowercased().range(of: searchText) != nil })
        tableView.reloadData()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let lower = searchBar.text!.lowercased()
        searchAlgorithm(searchText: lower)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        let lower = searchBar.text!.lowercased()
        searchAlgorithm(searchText: lower)
        searchBar.resignFirstResponder()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchAlgorithm()
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
}
