//
//  SearchView.swift
//  Mollection
//
//  Created by J on 2023/02/14.
//

import SwiftUI

struct SearchView: View {
    @State private var query = ""
    @ObservedObject var viewModel = SearchViewModel()
    
    var body: some View {
        List {
            HStack(alignment: .top) {
                PosterImageView(url: MovieAPI.imageURL + "/6WBeq4fCfn7AN0o21W9qNcRF2l9.jpg")
                    .frame(width: 80)
                Spacer()
                    
                VStack(alignment: .leading) {
                    Divider().opacity(0)
                    Text("AAAAAAA")
                        .font(.notoSans(.Medium, size: 14))
                    
                    Text("⭐️ 9.2")
                        .font(.notoSans(.Regular, size: 12))
                    
                    Text("1918년 제1차 세계 대전 말 뉴올리언즈. 80세의 외모를 가진 사내 아이가 태어난다. 그의 이름은 벤자민 버튼. 생김새때문에 양로원에 버려져 노인들과 함께")
                        .font(.notoSans(.Regular, size: 12))
                        .lineLimit(3)
                    
                    HStack {
                        Spacer()
                        Button {
                            print("AA")
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
        .listStyle(.plain)
        .searchable(text: $query)
        .onAppear {
            viewModel.fetch()
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
