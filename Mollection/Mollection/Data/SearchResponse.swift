//
//  SearchResponse.swift
//  Mollection
//
//  Created by J on 2023/02/14.
//

import Foundation

// MARK: - SearchResponse
struct SearchResponse: Codable, Identifiable {
    var id = UUID()
    let page: Int
    let results: [MediaResult]
    let totalResults, totalPages: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalResults = "total_results"
        case totalPages = "total_pages"
    }
}

// MARK: - MediaResult
struct MediaResult: Codable, Identifiable {
    let ids = UUID()
    let posterPath: String?
    let popularity: Double
    let id: Int
    let overview: String?
    let backdropPath: String?
    let voteAverage: Double?
    let mediaType: MediaType
    let firstAirDate: String?
    let originCountry: [String]?
    let genreIDS: [Int]?
    let originalLanguage: String?
    let voteCount: Int?
    let name, originalName: String?
    let adult: Bool?
    let releaseDate, originalTitle, title: String?
    let video: Bool?
    let profilePath: String?
    let knownFor: [MediaResult]?

    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case popularity, id, overview
        case backdropPath = "backdrop_path"
        case voteAverage = "vote_average"
        case mediaType = "media_type"
        case firstAirDate = "first_air_date"
        case originCountry = "origin_country"
        case genreIDS = "genre_ids"
        case originalLanguage = "original_language"
        case voteCount = "vote_count"
        case name
        case originalName = "original_name"
        case adult
        case releaseDate = "release_date"
        case originalTitle = "original_title"
        case title, video
        case profilePath = "profile_path"
        case knownFor = "known_for"
    }
}

extension MediaResult {
    func toDomain() -> MediaVO {
        return .init(id: id, backdropPath: backdropPath, posterPath: posterPath, title: title, releaseDate: releaseDate, overview: overview, voteAverage: voteAverage, mediaType: mediaType, genreIDS: genreIDS)
    }
}

enum MediaType: String, Codable {
    case movie = "movie"
    case person = "person"
    case tv = "tv"
}
