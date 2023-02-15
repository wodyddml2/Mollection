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
    @State var movieData: MovieResult?
    
    var body: some View {
        List(viewModel.movieList) { data in
            HStack(alignment: .top) {
                PosterImageView(url: MovieAPI.imageURL + (data.posterPath ?? ""))
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
                            movieData = data
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
        .scrollDismissesKeyboard(.immediately)
        .listStyle(.plain)
        .searchable(text: $viewModel.query, prompt: "검색해주세요")
        .onChange(of: viewModel.query) { newValue in
            if newValue != "" {
                viewModel.fetchData()
            }
        }
        .navigationDestination(isPresented: $isShowingDetail) {
            if let movieData = movieData {
                DetailView(movieData: movieData)
            }
        }
        .navigationTitle("")
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
