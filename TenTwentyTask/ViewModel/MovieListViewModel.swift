//
//  WeatherViewModel.swift
//  WeatherTask
//
//  Created by usama on 11/03/2022.
//

import Foundation

typealias MainThreadCompletion = (String?, Error?) -> Void


class MovieListViewModel {
    
    private(set) var upcomingMovies: [Movie] = []
    
    var newCount = 0
    private(set) var pageCount: Int?
    var shouldLoadMore = true

    var currentCount: Int {
        upcomingMovies.count
    }
    
    init() { }

}


extension MovieListViewModel {
    func fetchUpcomingMovies(completion: @escaping MainThreadCompletion) {
        
        
        let request: MovieRequestable = MovieRequest(apiKey: Constants.apiKey, page: 1)
        
        let endPoint = API.movieList(request: request)
        APIClient.shared.request(endPoint: endPoint, decode: MoviesRoot.self, error: DefaultError.self) { result in
            switch result {
            case let .success(root):
                                
                if let movieRoot = root as? MoviesRoot {
                    
                    self.upcomingMovies = movieRoot.results
                    completion(nil, nil)
                }
            case let .failure(error):
                
                if let unauthorizedError = error as? DefaultError {
                    
                    switch unauthorizedError {
                    case .unauthorized(let response):
                        if let root = response as? ErrorHandler {
                            completion(root.status_message, nil)
                        }
                    default:
                        completion(nil, error)
                    }
                }
                
                completion(nil, error)
            }
        }
    }
}
