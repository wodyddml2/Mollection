//
//  DetailViewModel.swift
//  Mollection
//
//  Created by J on 2023/02/15.
//

import Foundation
import Combine

class DetailViewModel: ObservableObject {
    @Published var genreList = [Genre]()
    
    private var cancellableSet = Set<AnyCancellable>()
    
    func fetchData(media: String) {
        MovieAPIService.shared.requestMovieAPI(type: GenreResponse.self, router: Router.genre(media: media))
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
                    self?.genreList = result.genres
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            .store(in: &cancellableSet)
    }
}
