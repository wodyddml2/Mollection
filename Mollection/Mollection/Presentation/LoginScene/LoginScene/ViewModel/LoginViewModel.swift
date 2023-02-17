//
//  LoginViewModel.swift
//  Mollection
//
//  Created by J on 2023/02/13.
//

import Foundation
import AuthenticationServices

final class LoginViewModel: ObservableObject {
    @Published var isLogin: Bool = false
    @Published var currentNonce: String?
    
    func idCredential(_ appleCredential: ASAuthorizationAppleIDCredential) {
        guard let nonce = currentNonce else {
            fatalError("Invalid state: A login callback was received, but no login request was sent.")
        }
        guard let appleIDToken = appleCredential.identityToken else {
            print("Unable to fetch identity token")
            return
        }
        guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
            print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
            return
        }
        
        FBAuth.signInWithApple(idTokenString: idTokenString, nonce: nonce) { [weak self] result in
            switch result {
            case .success(let result):
                UserManager.uid = result.user.uid
                self?.isLogin = true
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
