//
//  Font+Custom.swift
//  Mollection
//
//  Created by J on 2023/02/09.
//

import SwiftUI

extension Font {
    enum Family: String {
        case Regular
        case Medium
        case Bold
    }
    
    static func notoSans(_ family: Family = .Regular, size: CGFloat = 14) -> Font {
        return .custom("NotoSansKR-\(family)", size: size)
    }
}

