//
//  LoginView.swift
//  Mollection
//
//  Created by J on 2023/02/09.
//

import SwiftUI
import AuthenticationServices

struct LoginView: View {
    @StateObject private var viewModel: LoginViewModel = LoginViewModel()
    @Binding var isLogged: Bool
    @EnvironmentObject private var fbStore: FBStore
    
    var body: some View {
        NavigationStack {
            VStack {
                Image(systemName: "play.fill")
                    .foregroundColor(.customPurple)
                    .font(.system(size: 130))
                    .padding(.bottom)
                    .frame(height: 100)
                
                Text("Mollection")
                    .font(.notoSans(.Medium, size: 30))
                    .foregroundColor(.customPurple)
                    .padding(.bottom, 120)
                
                SignInWithAppleButton(.continue) { request in
                    let nonce = FBAuth.randomNonceString()
                    viewModel.currentNonce = nonce
                    request.requestedScopes = [.email, .fullName]
                    request.nonce = FBAuth.sha256(nonce)
                } onCompletion: { result in
                    switch result {
                    case .success(let authResult):
                        switch authResult.credential {
                        case let appleIDCredential as ASAuthorizationAppleIDCredential:
                            viewModel.idCredential(appleIDCredential)
                        default:
                            break
                        }
                    case .failure(let error):
                        print(error)
                    }
                }
                .frame(width: 280, height: 40)
                .navigationTitle("")
                .navigationDestination(isPresented: $viewModel.isLogin) {
                    SignupView(isLogged: $isLogged, fbStore: fbStore)
                }
            }
        }
    }

}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(isLogged: .constant(false))
    }
}
