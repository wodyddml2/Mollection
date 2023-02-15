//
//  GenreResponse.swift
//  Mollection
//
//  Created by J on 2023/02/15.
//

import Foundation


struct Genre {
    let id: Int
    let name: String
}

struct GenreList {
    var list: [Genre] = [
        Genre(id: 28, name: "액션"),
        Genre(id: 12, name: "모험"),
        Genre(id: 16, name: "애니메이션"),
        Genre(id: 35, name: "코미디"),
        Genre(id: 80, name: "범죄"),
        Genre(id: 99, name: "다큐멘터리"),
        Genre(id: 18, name: "드라마"),
        Genre(id: 10751, name: "가족"),
        Genre(id: 14, name: "판타지"),
        Genre(id: 27, name: "공포"),
        Genre(id: 10402, name: "음악"),
        Genre(id: 9648, name: "미스터리"),
        Genre(id: 10749, name: "로맨스"),
        Genre(id: 878, name: "SF"),
        Genre(id: 10770, name: "TV 영화"),
        Genre(id: 53, name: "스릴러"),
        Genre(id: 10752, name: "전쟁"),
        Genre(id: 37, name: "서부")
    ]
}
