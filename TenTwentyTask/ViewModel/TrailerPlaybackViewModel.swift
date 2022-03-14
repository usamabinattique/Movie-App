//
//  TrailerViewModel.swift
//  TenTwentyTask
//
//  Created by usama on 14/03/2022.
//

import Foundation

class TrailerPlaybackViewModel {
    
    private var movie: Movie
    private(set) var trailer: Trailer!
    
    init(movie: Movie) {
        self.movie = movie
    }
}


extension TrailerPlaybackViewModel {
    
    func fetchTrailer(completion: @escaping MainThreadCompletion) {
        
        let request: MovieDetailRequestable = MovieDetailRequest(apiKey: Constants.apiKey,
                                                                 movieId: movie.id)
        
        let endPoint = API.playbackVideo(request: request)
        APIClient.shared.request(endPoint: endPoint, decode: TrailerRoot.self, error: DefaultError.self) { result in
            switch result {
            case let .success(root):
                                
                if let trailerRoot = root as? TrailerRoot {
                    self.trailer = trailerRoot.results[0]
                    completion(nil, nil)
                }
            case let .failure(error):
                completion(nil, error)
            }
        }
    }
}
