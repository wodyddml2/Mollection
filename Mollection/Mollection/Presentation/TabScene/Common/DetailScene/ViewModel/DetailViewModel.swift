//
//  DetailViewModel.swift
//  Mollection
//
//  Created by J on 2023/02/15.
//

import Foundation
import Combine

final class DetailViewModel: ObservableObject {
    
    @Published var castData = [Cast]()
    @Published var genre: String = ""
    @Published var isShowAlert: Bool = false
    
    private let genreList = GenreList()
    
    private var cancellableSet = Set<AnyCancellable>()
    
    func configureGenre(mediaInfo: MediaVO) {
        guard let mediaGenre = mediaInfo.genreIDS else {return}
        
        switch mediaInfo.mediaType {
        case .movie:
            listOfGenres(mediaGenre: mediaGenre, genreType: genreList.movieGenre)
        case .tv:
            listOfGenres(mediaGenre: mediaGenre, genreType: genreList.tvGenre)
        case .person:
            break
        }
    }
    
    private func listOfGenres(mediaGenre: [Int], genreType: [GenreInfo]) {
        mediaGenre.forEach({ value in
            genreType.forEach { info in
                if info.id == value {
                    genre += "\(info.name) "
                }
            }
        })
        
        genre.remove(at: genre.index(before: genre.endIndex))
    }
    
    func fetchCastInfo(mediaInfo: MediaVO) {
        MediaAPIService.shared.requestMediaAPI(type: CastResponse.self, router: Router.cast(media: mediaInfo.mediaType.rawValue, id: mediaInfo.id))
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
                    self?.castData = result.cast
                    self?.castData.append(contentsOf: result.crew)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            .store(in: &cancellableSet)
    }
}
