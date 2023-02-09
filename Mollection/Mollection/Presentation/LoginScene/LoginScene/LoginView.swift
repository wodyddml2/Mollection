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
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
