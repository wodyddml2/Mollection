//
//  GenreResponse.swift
//  Mollection
//
//  Created by J on 2023/02/15.
//

import Foundation

// MARK: - GenreResponse
struct GenreResponse: Codable {
    let genres: [Genre]
}

// MARK: - Genre
struct Genre: Codable {
    let id: Int
    let name: String
}
