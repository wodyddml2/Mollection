//
//  Users.swift
//  Mollection
//
//  Created by J on 2023/02/14.
//

import Foundation

struct UserInfo: Identifiable {
    var id = UUID()
    var nickname: String
    var genre: String
}
