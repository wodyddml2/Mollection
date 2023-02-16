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
    let db = Firestore.firestore()
    
    func addData(nickname: String, genre: String) {
        let data = [
            "nickname": nickname,
            "genre": genre
        ]
        db.collection("Users").document(UserManager.uid ?? "")
            .collection("info").document("info")
            .setData(data)
    }
    
    func fetchData() {
        guard let uid = UserManager.uid else {return}
        let docRef = db.collection("Users").document(uid).collection("info").document("info")
        docRef.getDocument { document, error in
            guard error == nil else {
                return
            }
            if let document = document, document.exists {
                   let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                   print("Document data: \(dataDescription)")
               } else {
                   print("Document does not exist")
               }
        }
    }
    
}
