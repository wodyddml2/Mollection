//
//  TabBarButton.swift
//  Mollection
//
//  Created by J on 2023/02/14.
//

import SwiftUI

struct TabBarButton: View {
    
    var systemName: String
    var color: Color
    
    var body: some View {
        Button {
            
        } label: {
            VStack(spacing: 8) {
                Image(systemName: systemName)
                    .font(.system(size: 24))
                    .foregroundColor(color)
                
            }
        }

    }
}

struct TabBarButton_Previews: PreviewProvider {
    static var previews: some View {
        TabBarButton(systemName: "star", color: .red)
    }
}
