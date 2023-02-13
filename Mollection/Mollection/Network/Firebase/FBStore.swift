//
//  FBStore.swift
//  Mollection
//
//  Created by J on 2023/02/13.
//

import Foundation
import Firebase

class FBStore: ObservableObject {
    @Published var nickname: String = ""
    @Published var genre: String = ""
    
    init() {
        fetchData()
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
                    self.nickname = data["nickname"] as? String ?? ""
                    self.genre = data["genre"] as? String ?? ""
                }
            }
        }
    }
    
}
