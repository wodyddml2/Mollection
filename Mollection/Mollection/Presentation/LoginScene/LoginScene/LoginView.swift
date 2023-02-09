//
//  LoginView.swift
//  Mollection
//
//  Created by J on 2023/02/09.
//

import SwiftUI
import AuthenticationServices

struct LoginView: View {
   
    
    var body: some View {
        NavigationView {
            VStack {
                Image(systemName: "play.fill")
                    .foregroundColor(.customPurple)
                    .font(.system(size: 130))
                    .padding(.bottom)
                    .frame(height: 100)
            
                Text("Mollection")
                    .font(.notoSans(.Medium, size: 30))
                    .foregroundColor(.customPurple)
                
                Spacer().frame(height: 130)
                
                SignInWithAppleView()
                    .frame(width: 280, height: 40)
//                    .onTapGesture {
//                        showAppleLogin()
//                    }
//

            }
        }
    }
    
//    private func showAppleLogin() {
//        let request = ASAuthorizationAppleIDProvider().createRequest()
//        let nonce = FBAuth.randomNonceString()
//        currentNonce = nonce
//        request.requestedScopes = [.email, .fullName]
//        request.nonce = FBAuth.sha256(nonce)
//
//        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
//        authorizationController.performRequests()
//    }
    
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
