//
//  FBStore.swift
//  Mollection
//
//  Created by J on 2023/02/13.
//

import Foundation
import Firebase

enum FireStoreMedia: String {
    case id
    case title
    case background, poster
    case overview, release, average
    case mediaType, genre
}

final class FBStore: ObservableObject {
    private let db = Firestore.firestore()
    
    @Published var userInfo: UserInfo?
    @Published var navigationTitle: String = ""
    @Published var mediaInfos = [MediaInfo]()
    
    //MARK: User
    func addUserData(nickname: String, genre: String) {
        let data = [
            "nickname": nickname,
            "genre": genre
        ]
        db.collection("Users").document(UserManager.uid ?? "")
            .collection("info").document("info")
            .setData(data)
    }
    
    func getUserData() {
        guard let uid = UserManager.uid else {return}
        let docRef = db.collection("Users").document(uid).collection("info").document("info")
        docRef.getDocument { document, error in
            guard error == nil else {
                return
            }
            if let document = document, document.exists {
                let data = document.data()
                
                if let data = data {
                    self.userInfo = UserInfo(
                        nickname: data["nickname"] as? String ?? "",
                        genre: data["genre"] as? String ?? ""
                    )
                }
            }
        }
    }

    //MARK: Media
    func addMediaData(documentPath: String, mediaInfo: MediaVO) {
        let data: [String : Any] = [
            FireStoreMedia.id.rawValue: mediaInfo.id,
            FireStoreMedia.title.rawValue: mediaInfo.title ?? "",
            FireStoreMedia.background.rawValue: mediaInfo.backdropPath ?? "",
            FireStoreMedia.poster.rawValue: mediaInfo.posterPath ?? "",
            FireStoreMedia.overview.rawValue: mediaInfo.overview ?? "",
            FireStoreMedia.release.rawValue: mediaInfo.releaseDate ?? "",
            FireStoreMedia.average.rawValue: mediaInfo.voteAverage ?? "",
            FireStoreMedia.mediaType.rawValue: mediaInfo.mediaType.rawValue,
            FireStoreMedia.genre.rawValue: mediaInfo.genreIDS ?? []
        ]
        
        db.collection("Users").document(UserManager.uid ?? "")
            .collection("media")
            .document(documentPath)
            .collection(documentPath)
            .addDocument(data: data)
    }
    
    func getMediaData() {
        guard let uid = UserManager.uid else {return}
        let docRef = db.collection("Users").document(uid).collection("media")
        docRef.getDocuments { [weak self] snapshot, error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                    for document in snapshot!.documents {
//                        self?.mediaInfos.append(MediaInfo(mediaInfo: document.data()["info"] as! MediaVO, category: document.documentID))
                        print("\(document.documentID) => \(document.data())")
                    }
                    
                    self?.navigationTitle = self?.mediaInfos.first?.category ?? "Mollection"                
            }
        }
    }
    
}
