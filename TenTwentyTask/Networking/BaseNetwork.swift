//
//  BaseNetwork.swift
//  MindValleyTask
//
//  Created by usama on 03/01/2021.
//  Copyright © 2020 Usama. All rights reserved.
//

import Alamofire

typealias QueryPairItems = KeyValuePairs<String, String>?
typealias Headers = [HTTPHeader]

//
//enum HTTPContentType: String {
//    //If needed more content type can be define here
//    case json               = "application/json"
//    case xml                = "text/xml; charset=utf-8"
//    case formurlencoded     = "application/x-www-form-urlencoded"
//    case multipartFormData  = "formData"
//}

enum HTTPContentType: String {
    //If needed more content type can be define here
    case json               = "application/json"
    case xml                = "text/xml; charset=utf-8"
    case formurlencoded     = "application/x-www-form-urlencoded"
    case multipartFormData  = "formData"
}



typealias AFParameters = Parameters
protocol NetworkEndPoint: URLRequestConvertible {
    
    var url: URL { get }
    var method: HTTPMethod { get }
    var parameters: Parameters? { get set }
    var headers: HTTPHeaders? { get set }
    var caching: URLRequest.CachePolicy { get }
    var timeout: TimeInterval { get }
    var isTesting: Bool { get }
    var encodingType: ParameterEncoding { get }
    var contentType: HTTPContentType { get }
}



// Default implementation of protocol values
extension NetworkEndPoint {

    var contentType: HTTPContentType {
        .json
    }

    
    var method: HTTPMethod {
        .get
    }
    
    var encodingType: ParameterEncoding {
        URLEncoding.default
    }
    
    var headers: HTTPHeaders? {
        
        var headers: HTTPHeaders = [HTTPHeader(name: "Content-type", value: contentType.rawValue)]
    
        return headers
    }

    var parameters: Parameters? {
        nil
    }

    var caching: URLRequest.CachePolicy {
        .reloadIgnoringLocalAndRemoteCacheData
    }

    var timeout: TimeInterval {
        60
    }
    
    var isTesting: Bool {
        false
    }
}


extension URL {
    /// Appends `queryItems` to `URL`. In case of failure returns `self`
    func apending(_ queryItems: QueryPairItems) -> URL {
        guard let queryItems = queryItems else {
            return self
        }
        guard var components = URLComponents(string: absoluteString) else {
            return self
        }
        var items = components.queryItems ?? []
        for (key, val) in queryItems {
            items.append(URLQueryItem(name: key, value: val))
        }
        components.queryItems = items
        print(components.url)
        return components.url ?? self
    }
    
    func apending(_ queryItems: Parameters) -> URL {
       
        guard var components = URLComponents(string: absoluteString) else {
            return self
        }
        var items = components.queryItems ?? []
        for (key, val) in queryItems {
            items.append(URLQueryItem(name: key, value: (val as? String) ?? ""))
        }
        components.queryItems = items
        return components.url ?? self
    }
}



extension NetworkEndPoint {
    func asURLRequest() throws -> URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        
        if let headers = headers {
            headers.forEach { urlRequest.setValue($0.value, forHTTPHeaderField: $0.name) }
        }
        
        
//        switch method {
//          case .get:
//            urlRequest = try URLEncodedFormParameterEncoder().encode(parameters, into: urlRequest)
//          case .post:
//            urlRequest = try JSONParameterEncoder().encode(parameters, into: urlRequest)
//        default:
//            break
//        }
        
        
        return urlRequest
    }
}
