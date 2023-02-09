//
//  SignInWithAppleView.swift
//  Mollection
//
//  Created by J on 2023/02/09.
//

import SwiftUI
//MARK: Apple 로그인 프레임워크
import AuthenticationServices

struct SignInWithAppleView: UIViewRepresentable {
    func makeUIView(context: Context) -> some UIView {
        return ASAuthorizationAppleIDButton(type: .continue, style: .black)
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}

struct SignInWithApple_Previews: PreviewProvider {
    static var previews: some View {
        SignInWithAppleView()
    }
}
