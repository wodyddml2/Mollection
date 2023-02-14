//
//  SearchView.swift
//  Mollection
//
//  Created by J on 2023/02/14.
//

import SwiftUI

struct SearchView: View {
    @State private var query = ""
    
    var body: some View {
        List {
            Text("A")
        }
        .searchable(text: $query)
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
