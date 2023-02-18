//
//  MediaVO.swift
//  Mollection
//
//  Created by J on 2023/02/16.
//

import Foundation

struct MediaVO: Identifiable {
    var ids = UUID()
    var id: Int
    var backdropPath: String?
    var posterPath: String?
    var title, releaseDate: String?
    var overview: String?
    var voteAverage: Double?
    var mediaType: MediaType
    var genreIDS: [Int]?
}

