//
//  GenreInfo.swift
//  Mollection
//
//  Created by J on 2023/02/15.
//

import Foundation

struct GenreInfo {
    let id: Int
    let name: String
}

struct GenreList {
    var movieGenre: [GenreInfo] = [
        GenreInfo(id: 28, name: "액션"),
        GenreInfo(id: 12, name: "모험"),
        GenreInfo(id: 16, name: "애니메이션"),
        GenreInfo(id: 35, name: "코미디"),
        GenreInfo(id: 80, name: "범죄"),
        GenreInfo(id: 99, name: "다큐멘터리"),
        GenreInfo(id: 18, name: "드라마"),
        GenreInfo(id: 10751, name: "가족"),
        GenreInfo(id: 14, name: "판타지"),
        GenreInfo(id: 27, name: "공포"),
        GenreInfo(id: 10402, name: "음악"),
        GenreInfo(id: 9648, name: "미스터리"),
        GenreInfo(id: 10749, name: "로맨스"),
        GenreInfo(id: 878, name: "SF"),
        GenreInfo(id: 10770, name: "TV 영화"),
        GenreInfo(id: 53, name: "스릴러"),
        GenreInfo(id: 10752, name: "전쟁"),
        GenreInfo(id: 37, name: "서부")
    ]
    
    var tvGenre: [GenreInfo] = [
        GenreInfo(id: 10759, name: "액션 & 모험"),
        GenreInfo(id: 16, name: "애니메이션"),
        GenreInfo(id: 35, name: "코미디"),
        GenreInfo(id: 80, name: "범죄"),
        GenreInfo(id: 99, name: "다큐멘터리"),
        GenreInfo(id: 18, name: "드라마"),
        GenreInfo(id: 10751, name: "가족"),
        GenreInfo(id: 10762, name: "어린이"),
        GenreInfo(id: 9648, name: "미스터리"),
        GenreInfo(id: 10763, name: "뉴스"),
        GenreInfo(id: 10764, name: "Reality"),
        GenreInfo(id: 10765, name: "SF & 판타지"),
        GenreInfo(id: 10766, name: "Soap"),
        GenreInfo(id: 10767, name: "Talk"),
        GenreInfo(id: 10768, name: "전쟁"),
        GenreInfo(id: 37, name: "서부")
    ]
}
