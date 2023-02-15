//
//  MovieAPIService.swift
//  Mollection
//
//  Created by J on 2023/02/14.
//

import Foundation
import Combine
import Alamofire

class MovieAPIService {
    static let shared = MovieAPIService()
    
    private init() { }
    
    func requestMovieAPI<T: Codable>(type: T.Type = T.self, router: URLRequestConvertible) -> AnyPublisher<DataResponse<T, AFError>, Never> {
        return AF.request(router)
            .publishDecodable(type: T.self)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
}
