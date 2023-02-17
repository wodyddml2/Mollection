//
//  HomeView.swift
//  Mollection
//
//  Created by J on 2023/02/13.
//

import SwiftUI

struct HomeView: View {
    let a = [
        MediaAPI.imageURL + "/91V6NI1JXCTDhaSSkoY7T87hk09.jpg",
        MediaAPI.imageURL + "/zyzD9DGJWyA3VDMrS6ZzmW61SAd.jpg",
        MediaAPI.imageURL + "/pGMfidaVkjMVHXNIl7yippnipFT.jpg",
        MediaAPI.imageURL + "/6Ujbtp0NklUoQ67s32HyW6R5540.jpg"
    ]
    
    @State private var categoryTitle = "aaa"
    
    private let columns: [GridItem] = Array(repeating: .init(.flexible(), spacing: 10), count: 3)
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 15) {
                ForEach(a, id: \.self) { data in
                    VStack {
                        PosterImageView(url: data)
                            .frame(height: 170)
                        
                        Text("벤자민 버튼의 시간은 거꾸로 간다")
                            .font(.notoSans(.Regular, size: 12))
                            .lineLimit(1)
                    }
                    
                }
            }
            .padding(10)
        }
        .navigationTitle(Text(categoryTitle))
        .navigationBarTitleDisplayMode(.inline)
    
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
