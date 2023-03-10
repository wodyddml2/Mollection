//
//  FBAuth.swift
//  Mollection
//
//  Created by J on 2023/02/09.
//

import Foundation
import CryptoKit

import FirebaseAuth

struct FBAuth {
    static func signInWithApple(idTokenString: String, nonce: String, completion: @escaping (Result<AuthDataResult, Error>) -> Void) {
        let credential = OAuthProvider.credential(withProviderID: "apple.com",
                                                  idToken: idTokenString,
                                                  rawNonce: nonce)
        // Sign in with Firebase.
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if let err = error {
                
                print(err.localizedDescription)
                completion(.failure(err))
                return
            }
            guard let result = authResult else { return }
            
            completion(.success(result))
        }
    }
    
    static func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        let charset: [Character] =
        Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remainingLength = length
        
        while remainingLength > 0 {
            let randoms: [UInt8] = (0 ..< 16).map { _ in
                var random: UInt8 = 0
                let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                if errorCode != errSecSuccess {
                    fatalError(
                        "Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)"
                    )
                }
                return random
            }
            
            randoms.forEach { random in
                if remainingLength == 0 {
                    return
                }
                
                if random < charset.count {
                    result.append(charset[Int(random)])
                    remainingLength -= 1
                }
            }
        }
        
        return result
    }
    
    static func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            String(format: "%02x", $0)
        }.joined()
        
        return hashString
    }
    
    static func logoutMollection() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            UserManager.login = false
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    
}
