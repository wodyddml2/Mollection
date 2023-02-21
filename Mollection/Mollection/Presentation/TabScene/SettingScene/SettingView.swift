//
//  SettingView.swift
//  Mollection
//
//  Created by J on 2023/02/14.
//

import SwiftUI

enum Setting: String, CaseIterable, Identifiable {
    var id: Self { self }
    case category = "카테고리"
    case review = "리뷰 작성"
    case inquiry = "1:1 문의"
    case library = "오픈소스 라이브러리"
}

struct SettingView: View {
    @EnvironmentObject private var fbStore: FBStore
    @State private var isShowAlert: Bool = false
    @Binding var isLogged: Bool
    
    var body: some View {
        VStack {
            List {
                Section {
                    Text("\(fbStore.userInfo?.nickname ?? "")")
                        .font(.notoSans(.Regular, size: 16))
                } header: {
                    Text("내 정보")
                        .font(.notoSans(.Bold, size: 14))
                        .foregroundColor(.gray6)
                }
                
                Section {
                    ForEach(Setting.allCases) { value in
                        HStack {
                            Text(value.rawValue)
                                .font(.notoSans(.Medium, size: 14))
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .font(.system(size: 14))
                                .foregroundColor(.gray7)
                        }
                    }
                } header: {
                    Text("설정")
                        .font(.notoSans(.Bold, size: 14))
                        .foregroundColor(.gray6)
                }
                
                Section {
                    Text("로그아웃")
                        .font(.notoSans(.Medium, size: 14))
                        .foregroundColor(.red)
                        .onTapGesture {
                            
                            isShowAlert = true
                        }
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("설정")
            .navigationBarTitleDisplayMode(.inline)
            .alert(isPresented: $isShowAlert) {
                let ok = Alert.Button.default(Text("확인")) {
                    isLogged = false
                    FBAuth.logoutMollection()
                }
                let cancel = Alert.Button.cancel(Text("취소"))
                
                return Alert(title: Text("Mollection"), message: Text("로그아웃 하시겠습니까?"), primaryButton: ok, secondaryButton: cancel)
            }
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView(isLogged: .constant(false))
    }
}
