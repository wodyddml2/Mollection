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
    case backdropPath, posterPath
    case overview, releaseDate, voteAverage
    case mediaType, genreIDS
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
            FireStoreMedia.backdropPath.rawValue: mediaInfo.backdropPath ?? "",
            FireStoreMedia.posterPath.rawValue: mediaInfo.posterPath ?? "",
            FireStoreMedia.overview.rawValue: mediaInfo.overview ?? "",
            FireStoreMedia.releaseDate.rawValue: mediaInfo.releaseDate ?? "",
            FireStoreMedia.voteAverage.rawValue: mediaInfo.voteAverage ?? 0.0,
            FireStoreMedia.mediaType.rawValue: mediaInfo.mediaType.rawValue,
            FireStoreMedia.genreIDS.rawValue: mediaInfo.genreIDS ?? []
        ]
  
        db.collection("Users").document(UserManager.uid ?? "")
            .collection("media")
            .document("Mollection")
            .collection(documentPath)
            .addDocument(data: data)
    }
    
    func getMediaData() {
        guard let uid = UserManager.uid else {return}
        
        db.collection("Users").document(uid).collection("media")
            .document("Mollection")
            .collection("Mollection")
            .addSnapshotListener { [weak self] snapshot, error in
                guard let documents = snapshot?.documents else {
                    print("no")
                    return
                }
                self?.mediaInfos.removeAll()
                for document in documents {
                    self?.mediaInfos.append(MediaInfo(
                        mediaInfo: MediaVO(
                            id: document.data()[FireStoreMedia.id.rawValue] as! Int,
                            backdropPath: document.data()[FireStoreMedia.backdropPath.rawValue] as? String,
                            posterPath: document.data()[FireStoreMedia.posterPath.rawValue] as? String,
                            title: document.data()[FireStoreMedia.title.rawValue] as? String,
                            releaseDate: document.data()[FireStoreMedia.releaseDate.rawValue] as? String,
                            overview: document.data()[FireStoreMedia.overview.rawValue] as? String,
                            voteAverage: document.data()[FireStoreMedia.voteAverage.rawValue] as? Double,
                            mediaType: MediaType(rawValue: document.data()[FireStoreMedia.mediaType.rawValue] as! String) ?? .movie,
                            genreIDS: document.data()[FireStoreMedia.genreIDS.rawValue] as? [Int]),
                        category: document.documentID))
                }
            }
    }
    
    //        .document("Mollection")
    //        .collection("Mollection")
    //        .getDocuments { [weak self] snapshot, error in
    //            if let error = error {
    //                print(error.localizedDescription)
    //            } else {
    //
    //                for document in snapshot!.documents {
    //                    //                        self?.mediaInfos.append(MediaInfo(
    //                    //                            mediaInfo: MediaVO(
    //                    //                                id: document.data()[FireStoreMedia.id.rawValue] as! Int,
    //                    //                                backdropPath: document.data()[FireStoreMedia.background.rawValue] as? String,
    //                    //                                posterPath: document.data()[FireStoreMedia.poster.rawValue] as? String,
    //                    //                                title: document.data()[FireStoreMedia.title.rawValue] as? String,
    //                    //                                releaseDate: document.data()[FireStoreMedia.release.rawValue] as? String,
    //                    //                                overview: document.data()[FireStoreMedia.overview.rawValue] as? String,
    //                    //                                voteAverage: document.data()[FireStoreMedia.average.rawValue] as? Double,
    //                    //                                mediaType: MediaType(rawValue: document.data()[FireStoreMedia.mediaType.rawValue] as! String) ?? .movie,
    //                    //                                genreIDS: document.data()[FireStoreMedia.genre.rawValue] as? [Int]),
    //                    //                            category: document.documentID))
    //                    print("\(document.documentID) => \(document.data())")
    //                }
    //
    //                self?.navigationTitle = self?.mediaInfos.first?.category ?? "Mollection"
    //            }
    //        }
    
    //        .getDocument { document, error in
    //            if let document = document {
    //                print("Cached document data: \(document.data())")
    //             } else {
    //               print("Document does not exist in cache")
    //             }
    //        }
    
}
