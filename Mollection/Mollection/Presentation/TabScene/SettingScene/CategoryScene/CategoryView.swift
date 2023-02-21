//
//  CategoryView.swift
//  Mollection
//
//  Created by J on 2023/02/21.
//

import SwiftUI

struct CategoryView: View {
    @EnvironmentObject private var fbStore: FBStore
    @State private var isDelete: Bool = false
    @State private var isShowAlert: Bool = false
    @State private var categoryName: String = ""
    
    var body: some View {
        VStack {
            List(fbStore.categoryInfo.filter({$0.category != "Mollection"}), id: \.id) { data in
                HStack {
                    Text(data.category)
                    
                    Spacer()

                    Button {
                        isDelete = true
                    } label: {
                        Image(systemName: "xmark.circle")
                            .foregroundColor(.red)
                    }
                    .alert("\(data.category)를 삭제하시겠습니까?", isPresented: $isDelete) {
                        Button { } label: {
                            Text("취소")
                        }
                        
                        Button {
                            fbStore.deleteCategoryData(documentPath: data.documentID)
                        } label: {
                            Text("확인")
                                .foregroundColor(.red)
                        }
                    } message: {
                        Text("카테고리 삭제 시 데이터가 사라집니다")
                    }

                }
                
            }
        }
        .navigationTitle("카테고리 수정")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Image(systemName: "plus")
                    .onTapGesture {
                        isShowAlert = true
                    }
            }
        }
        .alert("Mollection", isPresented: $isShowAlert) {
            TextField("카테고리를 입력해주세요", text: $categoryName)
            
            Button { } label: {
                Text("취소")
            }
            
            Button {
                fbStore.addCategoryData(category: categoryName)
                categoryName = ""
            } label: {
                Text("저장")
            }
        } message: {
            Text("원하는 카테고리 만들어보아요")
        }
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView()
    }
}
