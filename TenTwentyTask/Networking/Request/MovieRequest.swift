//
//  MovieRequest.swift
//  TenTwentyTask
//
//  Created by usama on 12/03/2022.
//

import Foundation

public protocol BaseRequestModel { }


protocol MovieRequestable: BaseRequestModel {
    var apiKey: String { get set }
    var page: Int { get set }

}

struct MovieRequest: MovieRequestable {
    var apiKey: String
    var page: Int
}
