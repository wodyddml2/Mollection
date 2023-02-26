//
//  HomeViewModel.swift
//  Mollection
//
//  Created by J on 2023/02/21.
//

import Foundation
import Combine

final class HomeViewModel: ObservableObject {
    @Published var navigationTitle: String = "Mollection"
    private var cancellables = Set<AnyCancellable>()
    let subject = CurrentValueSubject<String, Never>("Mollection")
    private(set) var fbStore: FBStore
    
    init(fbStore: FBStore) {
        self.fbStore = fbStore
    }

    func categoryChange() {
        subject.sink { [weak self] value in
            self?.navigationTitle = value
            self?.fbStore.getMediaData(category: value)
        }
        .store(in: &cancellables)
    }
}
