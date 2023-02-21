//
//  FBStore.swift
//  Mollection
//
//  Created by J on 2023/02/13.
//

import Foundation
import Firebase

final class FBStore: ObservableObject {
    private let db = Firestore.firestore()
    
    @Published var userInfo: UserInfo?

    @Published var mediaInfos = [MediaInfo]()
    @Published var categorys = [String]()
    var checkCategory: Bool = false
    
    //MARK: User
    func addUserData(nickname: String, genre: String) {
        let data = [
            "nickname": nickname,
            "genre": genre
        ]
        db.collection(FireStoreID.Users.rawValue).document(UserManager.uid ?? "")
            .collection(FireStoreID.info.rawValue).document(FireStoreID.info.rawValue)
            .setData(data)
    }
    
    func getUserData() {
        guard let uid = UserManager.uid else {return}
        db.collection(FireStoreID.Users.rawValue).document(uid)
            .collection(FireStoreID.info.rawValue).document(FireStoreID.info.rawValue)
            .getDocument { document, error in
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
    func addMediaData(documentPath: String, mediaInfo: MediaVO, category: String) {
        let data: [String : Any] = [
            FireStoreMedia.id.rawValue: mediaInfo.id,
            FireStoreMedia.title.rawValue: mediaInfo.title ?? "",
            FireStoreMedia.backdropPath.rawValue: mediaInfo.backdropPath ?? "",
            FireStoreMedia.posterPath.rawValue: mediaInfo.posterPath ?? "",
            FireStoreMedia.overview.rawValue: mediaInfo.overview ?? "",
            FireStoreMedia.releaseDate.rawValue: mediaInfo.releaseDate ?? "",
            FireStoreMedia.voteAverage.rawValue: mediaInfo.voteAverage ?? 0.0,
            FireStoreMedia.mediaType.rawValue: mediaInfo.mediaType.rawValue,
            FireStoreMedia.genreIDS.rawValue: mediaInfo.genreIDS ?? [],
            "category": category
        ]
        
        db.collection(FireStoreID.Users.rawValue).document(UserManager.uid ?? "")
            .collection(FireStoreID.media.rawValue)
            .document(FireStoreID.Mollection.rawValue)
            .collection(documentPath)
            .addDocument(data: data)
    }
    
    func getMediaData(category: String) {
        guard let uid = UserManager.uid else {return}
        
        db.collection(FireStoreID.Users.rawValue).document(uid).collection(FireStoreID.media.rawValue)
            .document(FireStoreID.Mollection.rawValue)
            .collection(FireStoreID.Mollection.rawValue)
            .whereField("category", isEqualTo: category)
            .addSnapshotListener { [weak self] snapshot, error in
                guard let documents = snapshot?.documents else {
                    print("no document")
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
                        documentID: document.documentID, category: ""))
                }
            }
    }
    
    func deleteMediaData(documentPath: String) {
        guard let uid = UserManager.uid else {return}
        db.collection(FireStoreID.Users.rawValue).document(uid).collection(FireStoreID.media.rawValue)
            .document(FireStoreID.Mollection.rawValue)
            .collection(FireStoreID.Mollection.rawValue)
            .document(documentPath)
            .delete()
    }
    
    // 걍 싹 다 저장하는데 카테고리 부분에 이름을 넣어서 가져올 때 쿼리로 처리
    //MARK: Category
    func addCategoryData(category: String) {
        guard let uid = UserManager.uid else {return}
        db.collection(FireStoreID.Users.rawValue).document(uid).collection("Category")
            .addDocument(data: ["category": category])
    }
    
    func getCategoryData() {
        guard let uid = UserManager.uid else {return}
        db.collection(FireStoreID.Users.rawValue).document(uid).collection("Category")
            .addSnapshotListener { [weak self] snapshot, error in
                guard let documents = snapshot?.documents else {
                    print("no document")
                    return
                }
                
                self?.categorys.removeAll()
                
                for document in documents {
                    self?.categorys.append(document.data()["category"] as! String)
                }
            }
    }
    
    func checkCategoryData() {
        guard let uid = UserManager.uid else {return}
        db.collection(FireStoreID.Users.rawValue).document(uid).collection("Category")
            .getDocuments { [weak self] snapshot, error in
                guard let document = snapshot?.documents else {return}
                if document.isEmpty {
                    self?.checkCategory.toggle()
                }
            }
    }
}
