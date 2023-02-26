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
    @StateObject var viewModel: SignupViewModel
    @Binding var isLogged: Bool
    @State private var isShowAlert: Bool = false
    
    init(isLogged: Binding<Bool>, fbStore: FBStore) {
        self._viewModel = StateObject(wrappedValue: SignupViewModel(fbStore: fbStore))
        self._isLogged = isLogged
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Text("""
            환영합니다 👐
            Mollection에서 미디어 컬렉션을 만들어봐요
            """)
            .font(.notoSans(.Medium, size: 16))
            .foregroundColor(.gray7)
            .multilineTextAlignment(.center)
            .lineSpacing(8)
            
            VStack(alignment: .leading) {
                textFieldTitle(text: "닉네임")
                
                textFieldStyle("required", text: $viewModel.nickname, equal: .nickname)
                    .padding(.bottom, 20)
                
                textFieldTitle(text: "좋아하는 장르")
                
                textFieldStyle("option", text: $viewModel.genre, equal: .genre)
               
            }
            .padding(EdgeInsets(top: 90, leading: 60, bottom: 0, trailing: 60))
            .onSubmit {
                switch focusedField {
                case .nickname:
                    focusedField = .genre
                default:
                    break
                }
            }
            
            startButton
            
            Spacer()
        }
        .onAppear {
            viewModel.checkCategory()
        }
    }
}

extension SignupView {
    @ViewBuilder func textFieldTitle(text: String) -> some View {
        Text(text)
            .font(.notoSans(.Medium, size: 14))
            .foregroundColor(.gray7)
    }
    
    @ViewBuilder func textFieldStyle(_ placeholder: String, text: Binding<String>, equal: FocusedField) -> some View {
        TextField(placeholder, text: text)
            .focused($focusedField, equals: equal)
            .submitLabel(.done)
            .frame(height: 44)
            .padding(.horizontal, 10)
            .background(Color.gray2)
            .cornerRadius(5)
    }
    
    @ViewBuilder
    var startButton: some View {
        Button {
            if viewModel.isValid {
                viewModel.addData()
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
        .padding(.top, 90)
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView(isLogged: .constant(false), fbStore: FBStore())
    }
}













