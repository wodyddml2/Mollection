//
//  Router.swift
//  Mollection
//
//  Created by J on 2023/02/14.
//

import Foundation
import Alamofire

enum Router: URLRequestConvertible {
    case search(query: String, page: Int)
    case cast(media: String, id: Int)
    
    var baseURL: URL {
        switch self {
        case .search:
            return URL(string: MovieAPI.baseURL + MovieAPI.Search.multi)!
        case .cast(let media, let id):
            return URL(string: MovieAPI.baseURL + "/\(media)/\(id)/credits")!
        }
    }
    
    var parameters: Parameters {
        switch self {
        case .search(let query, let page):
            return [
                "api_key": APIKey.media,
                "language": "ko-KR",
                "query": query,
                "page": page
            ]
        case .cast:
            return [
                "api_key": APIKey.media,
                "language": "ko-KR"
            ]
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .search, .cast:
            return .get
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = baseURL
        var request = URLRequest(url: url)
        request.method = method
        switch self {
        case .search, .cast:
            return try URLEncoding.default.encode(request, with: parameters)
        }
    }
}
