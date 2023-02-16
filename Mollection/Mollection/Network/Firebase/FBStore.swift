//
//  FBStore.swift
//  Mollection
//
//  Created by J on 2023/02/13.
//

import Foundation
import Firebase

class FBStore: ObservableObject {
    private let db = Firestore.firestore()
    
    @Published var userInfo: UserInfo?
    
    func addUserData(nickname: String, genre: String) {
        let data = [
            "nickname": nickname,
            "genre": genre
        ]
        db.collection("Users").document(UserManager.uid ?? "")
            .collection("info").document("info")
            .setData(data)
    }
    
    func addMediaData(documentPath: String, mediaInfo: MediaVO) {
        db.collection("Users").document(UserManager.uid ?? "")
            .collection("media")
            .document(documentPath)
            .setData(["info": mediaInfo])
    }
    
    func fetchUserData() {
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
}
