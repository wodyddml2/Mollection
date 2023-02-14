//
//  FBStore.swift
//  Mollection
//
//  Created by J on 2023/02/13.
//

import Foundation
import Firebase

class FBStore: ObservableObject {
    @Published var users: Users?
    
    init() {
        fetchData()
    }
    
    func addData(nickname: String, genre: String) {
        let db = Firestore.firestore()
        db.collection("Users").addDocument(data: ["nickname": nickname, "genre": genre]) { error in
            if error == nil {
                return
            } else {
                // Handle the error
            }
        }
    }
    
    func fetchData() {
        let db = Firestore.firestore()
        guard let uid = UserManager.uid else {return}
        let docRef = db.collection("Users").document(uid)
        docRef.getDocument { document, error in
            guard error == nil else {
                return
            }
            
            if let document = document, document.exists {
                let data = document.data()
                if let data = data {
                    self.users?.id = document.documentID
                    self.users?.nickname = data["nickname"] as? String ?? ""
                    self.users?.genre = data["genre"] as? String ?? ""
                }
            }
        }
    }
    
}
