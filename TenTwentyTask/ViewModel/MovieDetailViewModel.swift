//
//  MovieDetailViewModel.swift
//  TenTwentyTask
//
//  Created by usama on 12/03/2022.
//

import Foundation

class MovieDetailViewModel {
    var movie: Movie!
    
    private(set) var movieDetail: MovieDetail?
    
    init(movie: Movie) {
        self.movie = movie
    }
}


extension MovieDetailViewModel {
    
    func fetchMovieDetail(completion: @escaping MainThreadCompletion) {
        
        let request: MovieDetailRequestable = MovieDetailRequest(apiKey: Constants.apiKey,
                                                                 movieId: movie.id)
        
        let endPoint = API.movieDetail(reqeust: request)
        APIClient.shared.request(endPoint: endPoint, decode: MovieDetail.self, error: DefaultError.self) { result in
            switch result {
            case let .success(root):
                                
                if let movieDetail = root as? MovieDetail {
                    self.movieDetail = movieDetail
                    completion(nil, nil)
                }
            case let .failure(error):
                completion(nil, error)
            }
        }
    }
}
