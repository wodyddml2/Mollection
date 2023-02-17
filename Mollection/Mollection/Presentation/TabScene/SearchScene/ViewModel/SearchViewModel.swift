//
//  SearchViewModel.swift
//  Mollection
//
//  Created by J on 2023/02/15.
//

import Foundation
import Combine

final class SearchViewModel: ObservableObject {
    @Published var query: String = ""
    
    @Published var mediaList = [MediaVO]()
    
    private var cancellableSet = Set<AnyCancellable>()
    
    func fetchData() {
        MediaAPIService.shared.requestMediaAPI(type: SearchResponse.self, router: Router.search(query: query, page: 1))
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print(error)
                case .finished:
                    break
                }
            } receiveValue: { [weak self] response in
                switch response.result {
                case .success(let result):
                    self?.mediaList = result.results.filter { $0.title != nil }
                        .map({ result in
                            result.toDomain()
                        })
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            .store(in: &cancellableSet)
    }
  
}
