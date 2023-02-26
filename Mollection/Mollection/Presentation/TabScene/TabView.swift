//
//  TabView.swift
//  Mollection
//
//  Created by J on 2023/02/14.
//

import SwiftUI

struct TabView: View {
    @EnvironmentObject private var fbStore: FBStore
    @State var selectedIndex: TabBarIndex = .house
    @State var showSearchView: Bool = false
    @Binding var isLogged: Bool

    let tabBarArr = TabBarIndex.allCases
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                switch selectedIndex {
                case .house:
                    NavigationView {
                        HomeView(fbStore: fbStore)
                    }
                case .ellipsis:
                    NavigationView {
                        SettingView(isLogged: $isLogged)
                    }
                default:
                   EmptyView()
                }
            }
            
            Divider()
            
            HStack {
                ForEach(tabBarArr, id: \.rawValue) { index in
                    tabButton(index: index)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            }
        }.onAppear {
            fbStore.getCategoryData()
            fbStore.getMediaData(category: "Mollection")
            fbStore.getUserData()
        }
    }
    
    @ViewBuilder func tabButton(index: TabBarIndex) -> some View {
        Button {
            if index == .plus {
                showSearchView = true
            } else {
                selectedIndex = index
            }
            
        } label: {
            if index == .plus {
                Image(systemName: index.rawValue)
                    .font(.system(size: 24))
                    .foregroundColor(.white)

                    .padding()
                    .frame(width: 60, height: 60)
                    .background(Color.customPurple)
                    .cornerRadius(30)
            } else {
                Image(systemName: index.rawValue)
                    .font(.system(size: 24))
                    .foregroundColor(selectedIndex == index ? .customPurple : .gray6)
            }
        }
        .sheet(isPresented: $showSearchView) {
            NavigationStack {
                SearchView()
            }
        }
    }
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        TabView(isLogged: .constant(false))
    }
}
