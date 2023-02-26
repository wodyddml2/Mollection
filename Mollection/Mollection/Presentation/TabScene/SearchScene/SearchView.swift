//
//  SearchView.swift
//  Mollection
//
//  Created by J on 2023/02/14.
//

import SwiftUI

struct SearchView: View {
    @ObservedObject private var viewModel = SearchViewModel()
    @State var isShowingDetail: Bool = false
    @State var mediaData: MediaVO?
    @EnvironmentObject private var fbStore: FBStore
    
    var body: some View {
        List(viewModel.mediaList) { data in
            HStack(alignment: .top) {
                PosterImageView(url: MediaAPI.imageURL + (data.posterPath ?? ""))
                    .frame(width: 80)
                Spacer()
                    
                VStack(alignment: .leading) {
                    Divider().opacity(0)
                    Text(data.title ?? "")
                        .font(.notoSans(.Medium, size: 14))
                    
                    Text("⭐️ \(data.voteAverage ?? 0.0, specifier: "%.1f")")
                        .font(.notoSans(.Regular, size: 12))
                    
                    Text(data.overview ?? "")
                        .font(.notoSans(.Regular, size: 12))
                        .lineLimit(3)
                    
                    Spacer().frame(height: 8)
                    
                    HStack {
                        Spacer()
                        
                        Button {
                            isShowingDetail = true
                            mediaData = data
                        } label: {
                            Text("더 보기")
                                .font(.notoSans(.Regular, size: 12))
                                .foregroundColor(.accentColor)
                        }
                    }
                }
            }
            .listRowSeparator(.hidden)
        }
        .scrollIndicators(.hidden)
        .scrollDismissesKeyboard(.immediately)
        .navigationTitle("미디어 검색")
        .navigationBarTitleDisplayMode(.inline)
        .listStyle(.plain)
        .searchable(text: $viewModel.query, prompt: "검색해주세요")
        .onChange(of: viewModel.query) { newValue in
            if newValue != "" {
                viewModel.fetchData()
            }
        }
        .navigationDestination(isPresented: $isShowingDetail) {
            if let mediaData = mediaData {
                DetailView(fbStore: fbStore, mediaData: mediaData)
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
