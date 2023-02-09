//
//  SplashView.swift
//  Mollection
//
//  Created by J on 2023/02/09.
//

import SwiftUI

struct SplashView: View {
    @State var isActive: Bool = false
    
    var body: some View {
        VStack {
            if isActive {
                if UserManager.login {
                    
                } else {
                    LoginView()
                }
            } else {
                Image(systemName: "play.fill")
                    .foregroundColor(.customPurple)
                    .font(.system(size: 130))
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                withAnimation {
                    isActive = true
                }
            }
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
