//
//  SplashView.swift
//  Mollection
//
//  Created by J on 2023/02/09.
//

import SwiftUI

struct SplashView: View {
    @State var isActive: Bool = false
    @State var isLogged: Bool = UserManager.login
    @EnvironmentObject var fbStore: FBStore
    var body: some View {
        VStack {
            if isActive {
                if isLogged {
                    TabView()
                } else {
                    LoginView(isLogged: $isLogged)
                }
            } else {
                Image(systemName: "play.fill")
                    .foregroundColor(.customPurple)
                    .font(.system(size: 130))
            }
        }
        .onAppear {
            fbStore.fetchUserData()
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
