//
//  Color+Custom.swift
//  Mollection
//
//  Created by J on 2023/02/09.
//

import SwiftUI

extension Color {
    init(hex: Int, opacity: Double = 1.0) {
        let red = Double((hex >> 16) & 0xff) / 255
        let green = Double((hex >> 8) & 0xff) / 255
        let blue = Double((hex >> 0) & 0xff) / 255
        
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
    }
    
    static let customPurple = Color(hex: 0x887DFF)
    
    static let gray2 = Color(hex: 0xEFEFEF)
    
    static let gray6 = Color(hex: 0xAAAAAA)
    
    static let gray7 = Color(hex: 0x888888)
}

