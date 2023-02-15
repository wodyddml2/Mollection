//
//  SearchViewModel.swift
//  Mollection
//
//  Created by J on 2023/02/15.
//

import Foundation
import Combine

class SearchViewModel: ObservableObject {
    private var cancellableSet = Set<AnyCancellable>()
    
    func fetch() {
        MovieAPIService.shared.requestMovieAPI(type: SearchResponse.self, router: SearchRouter.search(query: "iron", page: 1))
            .sink { completion in
                print(completion)
            } receiveValue: { response in
                switch response.result {
                case .success(let a):
                    print(a)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            .store(in: &cancellableSet)
    }
  
}
