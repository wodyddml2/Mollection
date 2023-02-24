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
    @EnvironmentObject private var fbStore: FBStore
    var body: some View {
        VStack {
            if isActive {
                if isLogged {
                    TabView(isLogged: $isLogged)
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
            withAnimation(.default.delay(1.2)) {
                isActive = true
            }
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
