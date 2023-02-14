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
    
    func requestMovieAPI<T: Codable>(type: T.Type = T.self, router: URLRequestConvertible) -> AnyCancellable {
        return AF.request(router)
            .publishDecodable(type: T.self)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { response in
                switch response.result {
                case .success(let success):
                    print(success)
                case .failure(let error):
                    print(error)
                }
            }
    }
    
}
