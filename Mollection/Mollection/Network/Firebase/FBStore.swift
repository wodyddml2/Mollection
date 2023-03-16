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
    @Published var categoryInfo = [CategoryInfo]()
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
            FireStoreMedia.category.rawValue: category
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
                
//                self?.mediaInfos.removeAll()
                if let index = self?.mediaInfos.firstIndex(where: { $0.category == category} ) {
                    self?.mediaInfos.remove(at: index)
                }
                
                var media: [Media] = []
                
                for document in documents {
                    media.append(Media(
                        documentID: document.documentID,
                        mediaInfo: MediaVO(
                            id: document.data()[FireStoreMedia.id.rawValue] as! Int,
                            backdropPath: document.data()[FireStoreMedia.backdropPath.rawValue] as? String,
                            posterPath: document.data()[FireStoreMedia.posterPath.rawValue] as? String,
                            title: document.data()[FireStoreMedia.title.rawValue] as? String,
                            releaseDate: document.data()[FireStoreMedia.releaseDate.rawValue] as? String,
                            overview: document.data()[FireStoreMedia.overview.rawValue] as? String,
                            voteAverage: document.data()[FireStoreMedia.voteAverage.rawValue] as? Double,
                            mediaType: MediaType(rawValue: document.data()[FireStoreMedia.mediaType.rawValue] as! String) ?? .movie,
                            genreIDS: document.data()[FireStoreMedia.genreIDS.rawValue] as? [Int])))
                }
                
                self?.mediaInfos.append(MediaInfo(media: media, category: category))
//                (MediaInfo(
//                    mediaInfo: MediaVO(
//                        id: document.data()[FireStoreMedia.id.rawValue] as! Int,
//                        backdropPath: document.data()[FireStoreMedia.backdropPath.rawValue] as? String,
//                        posterPath: document.data()[FireStoreMedia.posterPath.rawValue] as? String,
//                        title: document.data()[FireStoreMedia.title.rawValue] as? String,
//                        releaseDate: document.data()[FireStoreMedia.releaseDate.rawValue] as? String,
//                        overview: document.data()[FireStoreMedia.overview.rawValue] as? String,
//                        voteAverage: document.data()[FireStoreMedia.voteAverage.rawValue] as? Double,
//                        mediaType: MediaType(rawValue: document.data()[FireStoreMedia.mediaType.rawValue] as! String) ?? .movie,
//                        genreIDS: document.data()[FireStoreMedia.genreIDS.rawValue] as? [Int]),
//                    documentID: document.documentID,
//                    category: document.data()[FireStoreMedia.category.rawValue] as! String))
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
    
    //MARK: Category
    func addCategoryData(category: String) {
        guard let uid = UserManager.uid else {return}
        db.collection(FireStoreID.Users.rawValue).document(uid).collection(FireStoreID.Category.rawValue)
            .addDocument(data: ["category": category])
    }
    
    func getCategoryData() {
        guard let uid = UserManager.uid else {return}
        db.collection(FireStoreID.Users.rawValue).document(uid).collection(FireStoreID.Category.rawValue)
            .addSnapshotListener { [weak self] snapshot, error in
                guard let documents = snapshot?.documents else {
                    print("no document")
                    return
                }
                
                self?.categoryInfo.removeAll()
                
                for document in documents {
                    self?.categoryInfo.append(CategoryInfo(
                        category: document.data()["category"] as! String,
                        documentID: document.documentID))
                }
            }
    }
    
    func checkCategoryData() {
        guard let uid = UserManager.uid else {return}
        db.collection(FireStoreID.Users.rawValue).document(uid).collection(FireStoreID.Category.rawValue)
            .getDocuments { [weak self] snapshot, error in
                guard let document = snapshot?.documents else {return}
                if document.isEmpty {
                    self?.checkCategory.toggle()
                }
            }
    }
    
    func deleteCategoryData(documentPath: String) {
        guard let uid = UserManager.uid else {return}
        db.collection(FireStoreID.Users.rawValue).document(uid).collection(FireStoreID.Category.rawValue)
            .document(documentPath)
            .delete()
    }
}
