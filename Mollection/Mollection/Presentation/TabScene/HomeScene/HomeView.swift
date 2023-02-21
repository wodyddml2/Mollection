//
//  HomeView.swift
//  Mollection
//
//  Created by J on 2023/02/13.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var fbStore: FBStore
    
    private let columns: [GridItem] = Array(repeating: .init(.flexible(), spacing: 10), count: 3)
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 15) {
                ForEach(fbStore.mediaInfos, id: \.id) { data in
                    NavigationLink {
                        DetailView(mediaData: data.mediaInfo, documentID: data.documentID)
                    } label: {
                        VStack {
                            PosterImageView(url: data.mediaInfo.posterPath ?? "")
                                .frame(height: 170)
                            
                            Text(data.mediaInfo.title ?? "")
                                .font(.notoSans(.Regular, size: 12))
                                .foregroundColor(.black)
                                .lineLimit(1)
                        }
                    }
                }
            }
            .padding(10)
        }
        .navigationTitle(fbStore.navigationTitle)
        .navigationBarTitleDisplayMode(.inline)
        .toolbarTitleMenu(content: {
            ForEach(fbStore.categorys, id: \.self) { category in
                Button {
                    
                } label: {
                    Text(category)
                }

            }
        })
//        .toolbar {
//            ToolbarItem(placement: .navigationBarTrailing) {
//                Image(systemName: "menucard")
//            }
//        }
        .onAppear {
            print(fbStore.categorys)
        }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
