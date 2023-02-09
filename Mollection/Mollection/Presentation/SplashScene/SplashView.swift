//
//  SplashView.swift
//  Mollection
//
//  Created by J on 2023/02/09.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        Image(systemName: "play.fill")
            .foregroundColor(.customPurple)
            .font(.system(size: 130))
    
        if UserManager.login {
            
        } else {
            
        }
       
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
