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
    
    init() { }

}


extension MovieListViewModel {
    func fetchUpcomingMovies(completion: @escaping MainThreadCompletion) {
        
        let endPoint = API.movieList(request: BaseRequestModel)
        APIClient.shared.request(endPoint: endPoint, decode: DefaultError.self, error: DefaultError.self) { result in
            switch result {
            case let .success(root):
                                
                if let weatherRoot = root as? Weather {
                    self.weather = weatherRoot
                    completion(nil, nil)
                }
            case let .failure(error):
                
                if let unauthorizedError = error as? DefaultError {
                    
                    switch unauthorizedError {
                    case .unauthorized(let response):
                        if let root = response as? ErrorHandler {
                            completion(root.message, nil)
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
