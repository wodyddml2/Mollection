//
//  TabView.swift
//  Mollection
//
//  Created by J on 2023/02/14.
//

import SwiftUI

struct TabView: View {
    
    @State var selectedIndex: TabBarIndex = .house
    @State var showSearchView: Bool = false

    let tabBarArr = TabBarIndex.allCases
    
    var body: some View {
        VStack {
            ZStack {
                switch selectedIndex {
                case .house:
                    NavigationView {
                        HomeView()
                    }
                    .navigationTitle("Home")
                case .ellipsis:
                    NavigationView {
                        SettingView()
                    }
                default:
                   EmptyView()
                }
            }
            
            Spacer()
            
            Divider()
            
            HStack {
                ForEach(tabBarArr, id: \.rawValue) { index in
                    Spacer()
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
                    Spacer()
                }
            }
        }
    }
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        TabView()
    }
}