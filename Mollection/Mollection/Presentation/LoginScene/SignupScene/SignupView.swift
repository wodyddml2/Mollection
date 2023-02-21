//
//  SignupView.swift
//  Mollection
//
//  Created by J on 2023/02/09.
//

import SwiftUI

struct SignupView: View {
    enum FocusedField {
        case nickname
        case genre
    }
    @FocusState private var focusedField: FocusedField?
    
    @EnvironmentObject private var fbStore: FBStore
    @ObservedObject var viewModel: SignupViewModel = SignupViewModel()
    @Binding var isLogged: Bool
    @State private var isShowAlert: Bool = false
    
    var body: some View {
        VStack {
            Spacer()
                .frame(height: 20)

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
                
                TextField("required", text: $viewModel.nickname)
                    .focused($focusedField, equals: .nickname)
                    .submitLabel(.next)
                    .frame(height: 44)
                    .padding(.init(top: 0, leading: 10, bottom: 0, trailing: 10))
                    .background(Color.gray2)
                    .cornerRadius(5)
                
                Spacer()
                    .frame(height: 40)
                    
                Text("좋아하는 장르")
                    .font(.notoSans(.Medium, size: 14))
                    .foregroundColor(.gray7)
                
                TextField("option", text: $viewModel.favoriteGenre)
                    .focused($focusedField, equals: .genre)
                    .submitLabel(.done)
                    .frame(height: 44)
                    .padding(.init(top: 0, leading: 10, bottom: 0, trailing: 10))
                    .background(Color.gray2)
                    .cornerRadius(5)
            }
            .padding(.init(top: 0, leading: 60, bottom: 0, trailing: 60))
            .onSubmit {
                switch focusedField {
                case .nickname:
                    focusedField = .genre
                default:
                    break
                }
            }
            
            Spacer()
                .frame(height: 100)
            
            Button {
                if viewModel.isValid {
                    fbStore.addUserData(nickname: viewModel.nickname, genre: viewModel.favoriteGenre)
                    if fbStore.checkCategory {
                        fbStore.addCategoryData(category: "Mollection")
                        if viewModel.favoriteGenre != "" {
                            fbStore.addCategoryData(category: viewModel.favoriteGenre)
                        }
                    }
                    UserManager.login = true
                    isLogged = true
                } else {
                    isShowAlert = true
                }
            } label: {
                Text("Start")
                    .font(.notoSans(.Bold, size: 20))
                    .foregroundColor(.white)
            }
            .frame(width: 90, height: 90)
            .background(Color.customPurple)
            .clipShape(Circle())
            .alert(isPresented: $isShowAlert) {
                Alert(title: Text("닉네임을 입력해주세요"))
            }
            
            Spacer()
        }
        .onAppear {
            fbStore.checkCategoryData()
        }
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView(isLogged: .constant(false))
    }
}
