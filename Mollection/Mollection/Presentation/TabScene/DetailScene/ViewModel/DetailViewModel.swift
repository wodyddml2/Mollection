//
//  DetailViewModel.swift
//  Mollection
//
//  Created by J on 2023/02/15.
//

import Foundation
import Combine

class DetailViewModel: ObservableObject {
    @Published var genre: String = ""
    
    private var cancellableSet = Set<AnyCancellable>()
    
    func genre() {
        if !result.genres.isEmpty {
            if result.genres.count > 1 {
                for i in 0...result.genres.count - 1 {
                    if i == result.genres.count - 1 {
                        self?.genre += result.genres[i].name
                    } else {
                        self?.genre += "\(result.genres[i].name) / "
                    }
                }
            } else {
                self?.genre = result.genres[0].name
            }
        }
    }
}
