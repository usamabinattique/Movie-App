//
//  SearchViewModel.swift
//  TenTwentyTask
//
//  Created by usama on 12/03/2022.
//

import Foundation


class SearchViewModel {
    
    var filteredMovies: [Movie] = []
    private(set) var allMovies: [Movie] = []
    var inSearchMode = false
    
    init(movies: [Movie]) {
        allMovies = movies
    }
}
