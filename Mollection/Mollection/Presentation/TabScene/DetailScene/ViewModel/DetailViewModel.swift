//
//  DetailViewModel.swift
//  Mollection
//
//  Created by J on 2023/02/15.
//

import Foundation
import Combine

class DetailViewModel: ObservableObject {
    @Published var genre: String = ""
    
    private let genreList = GenreList()
    private var cancellableSet = Set<AnyCancellable>()
    
    func configureGenre(mediaInfo: MediaResult) {
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
    
    func listOfGenres(mediaGenre: [Int], genreType: [GenreInfo]) {
        mediaGenre.forEach({ value in
            genreType.forEach { info in
                if info.id == value {
                    genre += "\(info.name) "
                }
            }
        })
        
        genre.remove(at: genre.index(before: genre.endIndex))
    }
}
