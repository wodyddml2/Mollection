//
//  SearchViewModel.swift
//  Mollection
//
//  Created by J on 2023/02/15.
//

import Foundation
import Combine

class SearchViewModel: ObservableObject {
    @Published var query: String = ""
    
    @Published var movieList = [MovieResult]()
    
    private var cancellableSet = Set<AnyCancellable>()
    
    func fetchData() {
        MovieAPIService.shared.requestMovieAPI(type: SearchResponse.self, router: SearchRouter.search(query: query, page: 1))
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
                    self?.movieList = result.results.filter { $0.title != nil }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            .store(in: &cancellableSet)
    }
  
}
