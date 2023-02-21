//
//  HomeViewModel.swift
//  Mollection
//
//  Created by J on 2023/02/21.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    @Published var navigationTitle: String = "Mollection"
    private var cancellables = Set<AnyCancellable>()
    let subject = CurrentValueSubject<String, Never>("Mollection")

    func categoryChange(fbStore: FBStore) {
        subject.sink { value in
            self.navigationTitle = value
            fbStore.getMediaData(category: value)
        }
        .store(in: &cancellables)
    }
}
