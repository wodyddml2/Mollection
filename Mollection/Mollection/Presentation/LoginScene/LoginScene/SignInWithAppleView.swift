//
//  SignInWithAppleView.swift
//  Mollection
//
//  Created by J on 2023/02/09.
//

import SwiftUI
//MARK: Apple 로그인 프레임워크
import AuthenticationServices

struct SignInWithAppleView: View {
    
    @State private var currentNonce: String?
    
    var body: some View {
        SignInWithAppleButton(.continue) { request in
            let nonce = FBAuth.randomNonceString()
            currentNonce = nonce
            request.requestedScopes = [.email, .fullName]
            request.nonce = FBAuth.sha256(nonce)
        } onCompletion: { result in
            switch result {
            case .success(let authResult):
                switch authResult.credential {
                case let appleIDCredential as ASAuthorizationAppleIDCredential:
                    idCredential(appleIDCredential)
                default:
                    break
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func idCredential(_ appleCredential: ASAuthorizationAppleIDCredential) {
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
        
        FBAuth.signInWithApple(idTokenString: idTokenString, nonce: nonce) { result in
            switch result {
            case .success(let authResult):
                print(authResult)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

struct SignInWithApple_Previews: PreviewProvider {
    static var previews: some View {
        SignInWithAppleView()
    }
}
