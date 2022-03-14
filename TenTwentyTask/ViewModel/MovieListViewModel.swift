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
    var movieRequest: MovieRequestable!
    
    var newCount = 0
    var shouldLoadMore = true

    var currentCount: Int {
        upcomingMovies.count
    }
    
    init() {
        movieRequest = MovieRequest(apiKey: Constants.apiKey, page: 1)
    }
}


extension MovieListViewModel {
    func fetchUpcomingMovies(completion: @escaping MainThreadCompletion) {
                
        let endPoint = API.movieList(request: movieRequest)
        APIClient.shared.request(endPoint: endPoint, decode: MoviesRoot.self, error: DefaultError.self) { result in
            switch result {
            case let .success(root):
                                
                if let movieRoot = root as? MoviesRoot {
                    
                    self.addMovies(movies: movieRoot.results)
                    
                    if self.movieRequest.page > 1 {
                        self.newCount = movieRoot.results.count
                    }

                    
                    if self.movieRequest.page <= movieRoot.totalPages {
                        self.movieRequest.page += 1
                        
                        if self.movieRequest.page == movieRoot.totalPages {
                            self.shouldLoadMore = false
                        }
                    }
                    
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

private extension MovieListViewModel {
    func addMovies(movies: [Movie]) {
        self.upcomingMovies.append(contentsOf: movies)
    }
}
