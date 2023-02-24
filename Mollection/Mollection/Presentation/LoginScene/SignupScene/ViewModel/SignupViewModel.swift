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
    @Published var favoriteGenre: String = ""
    
    @Published var isValid: Bool = false
    var fbStore: FBStore
    
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
            .assign(to: \.isValid, on: self)
            .store(in: &cancellables)
    }
}
