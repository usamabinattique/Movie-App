//
//  MovieDetailRequest.swift
//  TenTwentyTask
//
//  Created by usama on 12/03/2022.
//

import Foundation


protocol MovieDetailRequestable: BaseRequestModel {
    var apiKey: String { get set }
    var movieId: Int { get set }

}

struct MovieDetailRequest: MovieDetailRequestable {
    var apiKey: String
    var movieId: Int
}
