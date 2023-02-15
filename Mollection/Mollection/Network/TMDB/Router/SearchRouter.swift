//
//  SearchRouter.swift
//  Mollection
//
//  Created by J on 2023/02/14.
//

import Foundation
import Alamofire

enum SearchRouter: URLRequestConvertible {
case search(query: String, page: Int)
    
    var baseURL: URL {
        switch self {
        case .search:
            return URL(string: MovieAPI.baseURL + MovieAPI.Search.multi)!
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
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .search:
            return .get
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = baseURL
        var request = URLRequest(url: url)
        request.method = method
        switch self {
        case .search:
            return try URLEncoding.default.encode(request, with: parameters)
        }
    }
}
