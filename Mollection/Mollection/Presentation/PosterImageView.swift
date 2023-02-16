//
//  PosterImageView.swift
//  Mollection
//
//  Created by J on 2023/02/14.
//

import SwiftUI
import Kingfisher

struct PosterImageView: View {
    var url: String
    
    var body: some View {
        if url == "" {
            Image(systemName: "person")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.customPurple)
                .cornerRadius(5)
        } else {
            KFImage(URL(string: MediaAPI.imageURL + url))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(5)
        }
       
    }
}

struct PosterImageView_Previews: PreviewProvider {
    static var previews: some View {
        PosterImageView(url: MediaAPI.imageURL + "/6WBeq4fCfn7AN0o21W9qNcRF2l9.jpg")
    }
}
