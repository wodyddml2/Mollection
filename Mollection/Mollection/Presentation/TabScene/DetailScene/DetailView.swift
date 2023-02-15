//
//  DetailView.swift
//  Mollection
//
//  Created by J on 2023/02/15.
//

import SwiftUI
import Kingfisher

struct DetailView: View {
    @State var url = MovieAPI.imageURL + "/8jsvRzKyB1s7YU9e40prhBJyIez.jpg"
    var body: some View {
        VStack {
            KFImage(URL(string: url))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .overlay(alignment: .bottomLeading) {
                    PosterImageView(url: MovieAPI.imageURL +  "/28iTo42JqjBXzq3aLtKfNwWzO4K.jpg")
                        .frame(width: 90)
                        .padding(.init(top: 0, leading: 28, bottom: 20, trailing: 0))
                }
                .overlay(alignment: .topLeading) {
                    Text("쇼 미 더 머니")
                        .font(.notoSans(.Bold, size: 20))
                        .foregroundColor(.white)
                        .lineLimit(1)
                        .padding(.init(top: 24, leading: 28, bottom: 0, trailing: 0))
                }
            
            Spacer()
                .frame(height: 8)
            
            VStack(alignment: .trailing) {
                Divider().opacity(0)
                Text("2008-12-25")
                    .font(.notoSans(.Regular, size: 14))
                    .padding(.trailing)
                
                Text("로맨스 / 판타지")
                    .font(.notoSans(.Regular, size: 14))
                    .padding(.trailing)
            }
            Spacer()
                .frame(height: 0)
            List {
                Section {
                    Text("세계 최강의 무기업체를 이끄는 CEO이자, 타고난 매력으로 화려한 삶을 살아가던 토니 스타크. 기자회견을 통해 자신이 아이언맨이라고 정체를 밝힌 이후, 정부로부터 아이언맨 수트를 국가에 귀속시키라는 압박을 받지만 이를 거부한다. 스타크 인더스트리의 운영권까지 수석 비서였던 페퍼 포츠에게 일임하고 히어로로서의 인기를 만끽하며 지내던 토니 스타크. 하지만 그 시각, 아이언맨의 수트 기술을 스타크 가문에 빼앗긴 후 쓸쓸히 돌아가신 아버지의 복수를 다짐해 온 위플래시는 수트의 원천 기술 개발에 성공, 치명적인 무기를 들고 직접 토니 스타크를 찾아 나선다.")
                        .font(.notoSans(.Regular, size: 12))
                } header: {
                    Text("줄거리")
                        .font(.notoSans(.Medium, size: 18))
                }
                
                Section {
                    HStack {
                        PosterImageView(url: MovieAPI.imageURL +  "/28iTo42JqjBXzq3aLtKfNwWzO4K.jpg")
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
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}
