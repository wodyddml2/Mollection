//
//  FireStore.swift
//  Mollection
//
//  Created by J on 2023/02/21.
//

import Foundation

enum FireStoreMedia: String {
    case id
    case title
    case backdropPath, posterPath
    case overview, releaseDate, voteAverage
    case mediaType, genreIDS
}

enum FireStoreID: String {
    case Users, Mollection
    case info, media
}
