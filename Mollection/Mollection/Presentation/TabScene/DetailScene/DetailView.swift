//
//  DetailView.swift
//  Mollection
//
//  Created by J on 2023/02/15.
//

import SwiftUI
import Kingfisher

struct DetailView: View {
    @StateObject private var viewModel = DetailViewModel()
    var mediaData: MediaResult
   
    var body: some View {
        VStack {
            KFImage(URL(string: MediaAPI.imageURL + (mediaData.backdropPath ?? "")))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .overlay(alignment: .bottomLeading) {
                    PosterImageView(url: MediaAPI.imageURL +  (mediaData.posterPath ?? ""))
                        .frame(width: 90)
                        .padding(.init(top: 0, leading: 28, bottom: 20, trailing: 0))
                }
                .overlay(alignment: .topLeading) {
                    Text(mediaData.title!)
                        .font(.notoSans(.Bold, size: 20))
                        .foregroundColor(.white)
                        .lineLimit(1)
                        .padding(.init(top: 24, leading: 28, bottom: 0, trailing: 0))
                }
            
            Spacer()
                .frame(height: 8)
            
            VStack(alignment: .trailing) {
                Divider().opacity(0)
                Text(mediaData.releaseDate ?? "")
                    .font(.notoSans(.Regular, size: 14))
                    .padding(.trailing)
                
                Text(viewModel.genre)
                    .font(.notoSans(.Regular, size: 14))
                    .padding(.trailing)
                    
            }
            Spacer()
                .frame(height: 0)
            List {
                Section {
                    Text(mediaData.overview ?? "정보 없음")
                        .font(.notoSans(.Regular, size: 12))
                } header: {
                    Text("줄거리")
                        .font(.notoSans(.Medium, size: 18))
                }
                
                Section {
                    HStack {
                        PosterImageView(url: MediaAPI.imageURL +  "/28iTo42JqjBXzq3aLtKfNwWzO4K.jpg")
                            .frame(width: 52)
                        VStack(alignment: .leading) {
                            Spacer()
                                .frame(height: 18)
                            Text("브래드")
                                .font(.notoSans(.Medium, size: 14))
                            Spacer()
                                .frame(height: 12)
                            Text("ㄸㄸㄸㄸ / ㄸㄸ")
                                .font(.notoSans(.Regular, size: 12))
                                .foregroundColor(.gray7)
                            Spacer()
                        }
                    }
                } header: {
                    Text("출연진")
                        .font(.notoSans(.Medium, size: 18))
                }
            }
            .listStyle(.plain)
            
            Spacer()
        }
        
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Image(systemName: "bookmark.fill")
                    .foregroundColor(.customPurple)
            }
        }
        .onAppear {
            viewModel.configureGenre(mediaInfo: mediaData)
        }
       
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(mediaData: MediaResult(posterPath: nil, popularity: 1.0, id: 1, overview: nil, backdropPath: nil, voteAverage: nil, mediaType: MediaType.movie, firstAirDate: nil, originCountry: nil, genreIDS: nil, originalLanguage: nil, voteCount: nil, name: nil, originalName: nil, adult: nil, releaseDate: nil, originalTitle: nil, title: nil, video: nil, profilePath: nil, knownFor: nil))
    }
}
