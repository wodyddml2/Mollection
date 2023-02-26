//
//  MovieAPIService.swift
//  Mollection
//
//  Created by J on 2023/02/14.
//

import Foundation
import Combine
import Alamofire

final class MediaAPIService {
    static let shared = MediaAPIService()
    
    private init() { }
//    AnyPublisher<DataResponse<T, AFError>, Never>
    func requestMediaAPI<T: Codable>(type: T.Type = T.self, router: URLRequestConvertible) -> Future<T, AFError> {
        return Future { promise in
            AF.request(router)
                .responseDecodable(of: T.self) { response in
                    switch response.result {
                    case .success(let value):
                        promise(.success(value))
                    case .failure(let error):
                        promise(.failure(error))
                        break
                    }
                }
        }
        
//        return AF.request(router)
//            .publishDecodable(type: T.self)
//            .receive(on: DispatchQueue.main)
//            .eraseToAnyPublisher()
    }
    
}
