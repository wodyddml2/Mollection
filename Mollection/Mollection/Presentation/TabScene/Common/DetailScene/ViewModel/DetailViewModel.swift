//
//  DetailViewModel.swift
//  Mollection
//
//  Created by J on 2023/02/15.
//

import Foundation
import Combine

final class DetailViewModel: ObservableObject {
    enum ActiveAlert {
        case normal
        case duplicated
    }

    @Published var castData = [Cast]()
    @Published var genre: String = ""
    @Published var isShowAlert: Bool = false
    @Published var isactiveAlert: ActiveAlert = .normal
    @Published var selectionIndex: Int = 0
    var categoryCount: Int {
        fbStore.categoryInfo.count
    }
    
    private let genreList = GenreList()
    
    private var cancellableSet = Set<AnyCancellable>()
    
    private var fbStore: FBStore
    private var mediaData: MediaVO
    
    init(fbStore: FBStore, mediaData: MediaVO) {
        self.fbStore = fbStore
        self.mediaData = mediaData
    }
    
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
            } receiveValue: { [weak self] result in
                self?.castData = result.cast
                self?.castData.append(contentsOf: result.crew)
            }
            .store(in: &cancellableSet)
    }
    
    func pickerBindingSet(index: Int) {
        selectionIndex = index
        if fbStore.mediaInfos.filter({$0.mediaInfo.id == mediaData.id}).isEmpty {
            isactiveAlert = .normal
        } else {
            isactiveAlert = .duplicated
        } // 고쳐야함
        isShowAlert = true
    }
    
    func alertOkAction(documentID: String?) {
        if let documentID = documentID {
            fbStore.deleteMediaData(documentPath: documentID)
        } else {
            fbStore.addMediaData(
                documentPath: "Mollection",
                mediaInfo: mediaData,
                category: fbStore.categoryInfo[selectionIndex].category
            )
        }
    }
    
    func categoryTitle(index: Int) -> String {
        return fbStore.categoryInfo[index].category
    }
}
