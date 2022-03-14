//
//  API.swift
//  WeatherTask
//
//  Created by usama on 11/03/2022.
//

import UIKit

/// Main `NetworkEndPoint`s for the app
enum API: NetworkEndPoint {
    case movieList(request: BaseRequestModel)
    case movieDetail(reqeust: BaseRequestModel)
}

/// Implementation of `NetworkEndPoint`
 extension API {
     
    var isTesting: Bool {
        false
    }
     
    /// path for the endpoint
     var path: String {
         
         switch self {
         case .movieList:
             return "movie/upcoming"
         case .movieDetail(let request):
             return "movie/\((request as! MovieDetailRequestable).movieId)"
         }
     }
     
     /// Query items for endpoint
     var queryItems: KeyValuePairs<String, String>? {
         switch self {
         case let .movieList(movieRequest):
             if let movieRequest = movieRequest as? MovieRequestable {
                 return ["api_key": movieRequest.apiKey,
                         "page": "\(movieRequest.page)"]
             }
             return nil
         case let .movieDetail(detailRequest):
             if let detailRequest = detailRequest as? MovieDetailRequestable {
                 return ["api_key": detailRequest.apiKey]
             }
             return nil
         }
     }

    /// Body dictionary for endpoints
    var body: Data? {
         nil
    }
    var contentType: HTTPContentType {
        .json
    }

    /// http method for endpoint
    var method: HTTPMethod {
        .get
    }

    /// Default headers
     var headers: [String: String]? {
        nil
     }
     
     var url: URL {
         URL(string: Constants.baseUrl)!.appendingPathComponent(path)
     }
 }
