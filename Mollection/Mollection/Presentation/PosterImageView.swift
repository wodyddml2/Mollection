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
            KFImage(URL(string: url))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(5)
    }
}

struct PosterImageView_Previews: PreviewProvider {
    static var previews: some View {
        PosterImageView(url: MediaAPI.imageURL + "/6WBeq4fCfn7AN0o21W9qNcRF2l9.jpg")
    }
}
