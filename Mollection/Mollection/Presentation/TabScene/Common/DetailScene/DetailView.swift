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
    @EnvironmentObject private var fbStore: FBStore
    
    var mediaData: MediaVO
    var documentID: String? = nil
    
    var body: some View {
        VStack {
            KFImage(URL(string: MediaAPI.imageURL + (mediaData.backdropPath ?? "")))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .overlay(alignment: .bottomLeading) {
                    PosterImageView(url: mediaData.posterPath ?? "")
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
                
                Spacer()
                    .frame(height: 6)
                
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
                    ForEach(viewModel.castData, id: \.ids) { data in
                        HStack {
                            PosterImageView(url: data.profilePath ?? "")
                                .frame(width: 52)
                            VStack(alignment: .leading) {
                                Spacer()
                                    .frame(height: 18)
                                Text(data.name)
                                    .font(.notoSans(.Medium, size: 14))
                                Spacer()
                                    .frame(height: 12)
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
            .listStyle(.plain)
            .scrollIndicators(.hidden)
            Spacer()
        }
        
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                if documentID != nil {
                    Image(systemName: "trash")
                        .foregroundColor(.red)
                        .onTapGesture {
                            viewModel.isactiveAlert = .normal
                            viewModel.isShowAlert = true
                        }
                } else {
                    Image(systemName: "bookmark.fill")
                        .foregroundColor(.customPurple)
                        .onTapGesture {
                            if fbStore.mediaInfos.filter({$0.mediaInfo.id == mediaData.id}).isEmpty {
                                viewModel.isactiveAlert = .normal
                            } else {
                                viewModel.isactiveAlert = .duplicated
                            }
                            viewModel.isShowAlert = true
                        }
                }
                
                //                Menu {
                //                    Picker(selection: Binding(get: {selectionIndex}, set: {
                //                        selectionIndex = $0
                //                        isShowAlert = true
                //                    }) ) {
                //                        if fbStore.mediaInfos.isEmpty {
                //                            ForEach(0..<1) { _ in
                //                                Text("Mollection")
                //                            }
                //                        } else {
                //                            ForEach(fbStore.mediaInfos, id: \.id) { value in
                //                                Text(value.category)
                //                            }
                //                        }
                //                    } label: {
                //                        EmptyView()
                //                    }
                //                } label: {
                //                    Image(systemName: "bookmark.fill")
                //                        .foregroundColor(.customPurple)
                //                }
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
                    if let documentID = documentID {
                        fbStore.deleteMediaData(documentPath: documentID)
                    } else {
                        fbStore.addMediaData(documentPath: "Mollection", mediaInfo: mediaData)
                    }
                    //                if fbStore.mediaInfos.isEmpty {
                    //                    fbStore.addMediaData(documentPath: "Mollection", mediaInfo: mediaData)
                    //                } else {
                    //                    fbStore.addMediaData(documentPath: "ABC", mediaInfo: mediaData)
                    //                }
                }
                let cancel = Alert.Button.cancel(Text("취소"))
                
                return Alert(title: Text(mediaData.title ?? ""), message: Text(documentID == nil ? "해당 자료를 저장하시겠습니까?" : "삭제하시겠습니까?"), primaryButton: ok, secondaryButton: cancel)
            case .duplicated:
                return  Alert(title: Text("이미 저장된 미디어입니다"))
            }
            
        }
        
        
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(mediaData: MediaVO(id: 1, mediaType: .movie))
    }
}
