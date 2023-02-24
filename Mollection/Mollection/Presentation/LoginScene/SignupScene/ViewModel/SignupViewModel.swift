//
//  SignupViewModel.swift
//  Mollection
//
//  Created by J on 2023/02/13.
//

import Foundation
import Combine

final class SignupViewModel: ObservableObject {
    @Published var nickname: String = ""
    @Published var genre: String = ""
    
    @Published var isValid: Bool = false
    private var fbStore: FBStore
    
    private var cancellables = Set<AnyCancellable>()
    
    private var isNicknameValid: AnyPublisher<Bool, Never> {
        return $nickname
            .map { input in
                return input.count > 0
            }
            .eraseToAnyPublisher()
    }
    
    
    init(fbStore: FBStore) {
        self.fbStore = fbStore
        self.isNicknameValid
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] value in
                self?.isValid = value
            })
            .store(in: &cancellables)
    }
    
    func addData() {
        fbStore.addUserData(nickname: nickname, genre: genre)
        if fbStore.checkCategory {
            fbStore.addCategoryData(category: "Mollection")
            if genre != "" {
                fbStore.addCategoryData(category: genre)
            }
        }
    }
    
    func checkCategory() {
        fbStore.checkCategoryData()
    }
}
