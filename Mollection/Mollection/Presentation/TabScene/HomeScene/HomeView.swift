//
//  HomeView.swift
//  Mollection
//
//  Created by J on 2023/02/13.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var fbStore: FBStore
    @StateObject private var viewModel: HomeViewModel
    
    private let columns: [GridItem] = Array(repeating: .init(.flexible(), spacing: 10), count: 3)
    
    init(fbStore: FBStore) {
        self._viewModel = StateObject(wrappedValue: HomeViewModel(fbStore: fbStore))
    }
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 15) {
                ForEach(viewModel.media ?? [], id: \.documentID) { data in
                    NavigationLink {
                        DetailView(fbStore: fbStore, mediaData: data.mediaInfo, documentID: data.documentID)
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
        .navigationTitle(viewModel.navigationTitle)
        .navigationBarTitleDisplayMode(.inline)
        .toolbarTitleMenu(content: {
            ForEach(viewModel.fbStore.categoryInfo, id: \.id) { info in
                Button {
                    viewModel.subject.send(info.category)
                } label: {
                    Text(info.category)
                }
            }
        })
        .onAppear {
            viewModel.categoryChange()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(fbStore: FBStore())
    }
}
