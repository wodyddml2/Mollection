//
//  DetailView.swift
//  Mollection
//
//  Created by J on 2023/02/15.
//

import SwiftUI
import Kingfisher

struct DetailView: View {
    @StateObject private var viewModel: DetailViewModel
    
    var mediaData: MediaVO
    var documentID: String?
    
    init(fbStore: FBStore, mediaData: MediaVO, documentID: String?) {
        self._viewModel = StateObject(wrappedValue: DetailViewModel(fbStore: fbStore, mediaData: mediaData))
        self.mediaData = mediaData
        self.documentID = documentID
    }
    
    var body: some View {
        VStack(spacing: 0) {
            mediaImage
                .padding(.bottom, 8)
            
            VStack(spacing: 6) {
                genreAndReleaseText(text: mediaData.releaseDate ?? "")
                genreAndReleaseText(text: viewModel.genre)
            }
            
            List {
                overViewSection
                castSection
            }
            .listStyle(.plain)
            .scrollIndicators(.hidden)
            Spacer()
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                navigationButton
            }
        }
        .onAppear {
            viewModel.configureGenre(mediaInfo: mediaData)
            viewModel.fetchCastInfo(mediaInfo: mediaData)
        }
        .alert(isPresented: $viewModel.isShowAlert) {
            switch viewModel.isactiveAlert {
            case .normal:
                let ok = Alert.Button.default(Text("확인")) {
                    viewModel.alertOkAction(documentID: documentID)
                }
                let cancel = Alert.Button.cancel(Text("취소"))
                
                return Alert(title: Text(mediaData.title ?? ""), message: Text(documentID == nil ? "해당 자료를 저장하시겠습니까?" : "삭제하시겠습니까?"), primaryButton: ok, secondaryButton: cancel)
            case .duplicated:
                return  Alert(title: Text("이미 저장된 미디어입니다"))
            }
        }
    }
}

extension DetailView {
    @ViewBuilder var mediaImage: some View {
        KFImage(URL(string: MediaAPI.imageURL + (mediaData.backdropPath ?? "")))
            .resizable()
            .aspectRatio(contentMode: .fit)
            .overlay(alignment: .bottomLeading) {
                PosterImageView(url: mediaData.posterPath ?? "")
                    .frame(width: 90)
                    .padding(EdgeInsets(top: 0, leading: 28, bottom: 20, trailing: 0))
            }
            .overlay(alignment: .topLeading) {
                Text(mediaData.title!)
                    .font(.notoSans(.Bold, size: 20))
                    .foregroundColor(.white)
                    .lineLimit(1)
                    .padding(EdgeInsets(top: 24, leading: 28, bottom: 0, trailing: 0))
            }
    }
    
    @ViewBuilder func genreAndReleaseText(text: String) -> some View {
        Text(text)
            .font(.notoSans(.Regular, size: 14))
            .frame(maxWidth: .infinity , alignment: .trailing)
            .padding(.trailing)
    }
    
    @ViewBuilder var overViewSection: some View {
        Section {
            Text(mediaData.overview ?? "정보 없음")
                .font(.notoSans(.Regular, size: 12))
        } header: {
            Text("줄거리")
                .font(.notoSans(.Medium, size: 18))
        }
    }
    
    @ViewBuilder var castSection: some View {
        Section {
            ForEach(viewModel.castData, id: \.ids) { data in
                HStack {
                    PosterImageView(url: data.profilePath ?? "")
                        .frame(width: 52)
                    VStack(alignment: .leading, spacing: 12) {
                        Text(data.name)
                            .font(.notoSans(.Medium, size: 14))
                            .padding(.top, 18)
                        
                        Text("\(data.character ?? "") / \(data.knownForDepartment.rawValue)")
                            .font(.notoSans(.Regular, size: 12))
                            .foregroundColor(.gray7)
                        Spacer()
                    }
                }
            }
        } header: {
            Text("출연진 / 제작진")
                .font(.notoSans(.Medium, size: 18))
        }
    }
    
    @ViewBuilder var navigationButton: some View {
        if documentID != nil {
            Image(systemName: "trash")
                .foregroundColor(.red)
                .onTapGesture {
                    viewModel.isactiveAlert = .normal
                    viewModel.isShowAlert = true
                }
        } else {
            Menu {
                Picker(selection: Binding(get: {viewModel.selectionIndex}, set: {
                    viewModel.pickerBindingSet(index: $0)
                }) ) {
                    ForEach(0..<viewModel.categoryCount) {
                        Text(viewModel.categoryTitle(index: $0))
                    }
                } label: {
                    EmptyView()
                }
            } label: {
                Image(systemName: "bookmark.fill")
                    .foregroundColor(.customPurple)
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(fbStore: FBStore(), mediaData: MediaVO(id: 1, mediaType: .movie), documentID: nil)
    }
}
