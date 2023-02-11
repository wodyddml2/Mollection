//
//  SignupView.swift
//  Mollection
//
//  Created by J on 2023/02/09.
//

import SwiftUI

struct SignupView: View {
    @State var nickname: String = ""
    @State var favoriteGenre: String = ""
    
    var body: some View {
        VStack {
            Spacer()
                .frame(height: 80)
            
            Text("""
            환영합니다 👐
            Mollection에서 미디어 컬렉션을 만들어봐요
            """)
            .font(.notoSans(.Medium, size: 16))
            .foregroundColor(.gray7)
            .multilineTextAlignment(.center)
            .lineSpacing(8)
            
            Spacer()
                .frame(height: 90)
            
            VStack(alignment: .leading) {
                Text("닉네임")
                    .font(.notoSans(.Medium, size: 14))
                    .foregroundColor(.gray7)
                
                TextField("", text: $nickname)
                    .frame(height: 44)
                    .background(Color.gray2)
                    .cornerRadius(5)
                
                Spacer()
                    .frame(height: 40)
                    
                Text("좋아하는 장르")
                    .font(.notoSans(.Medium, size: 14))
                    .foregroundColor(.gray7)
                
                TextField("", text: $favoriteGenre)
                    .frame(height: 44)
                    .background(Color.gray2)
                    .cornerRadius(5)
            }
            .padding(.init(top: 0, leading: 60, bottom: 0, trailing: 60))
            
            Spacer()
                .frame(height: 100)
            
            Button {
                print("Start")
            } label: {
                Text("Start")
                    .font(.notoSans(.Bold, size: 20))
                    .foregroundColor(.white)
            }
            .frame(width: 90, height: 90)
            .background(Color.customPurple)
            .clipShape(Circle())

            Spacer()
        }
        
        
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}
