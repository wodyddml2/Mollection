//
//  MediaInfo.swift
//  Mollection
//
//  Created by J on 2023/02/18.
//

import Foundation

struct MediaInfo: Identifiable {
    var id = UUID()
    var media: [Media]
    var category: String
}

struct Media {
    var documentID: String
    var mediaInfo: MediaVO
}
