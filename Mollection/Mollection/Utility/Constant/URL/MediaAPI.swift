//
//  MovieAPI.swift
//  Mollection
//
//  Created by J on 2023/02/14.
//

import Foundation

enum MediaAPI {
    static let baseURL = "https://api.themoviedb.org/3"
    static let imageURL = "https://image.tmdb.org/t/p/w500"
    enum Search {
        static let multi = "/search/multi"
    }
}
