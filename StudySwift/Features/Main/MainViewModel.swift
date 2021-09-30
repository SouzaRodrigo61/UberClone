//
//  MainViewModel.swift
//  StudySwift
//
//  Created by Rodrigo Santos on 27/09/21.
//

import Foundation
import Combine

struct MainViewModel {
    let navigator: MainNavigatorType
    let useCase: MainUseCaseType
}

extension MainViewModel: ViewModel {
    final class Input {
        @Published var email = ""
        @Published var password = ""
        
    }
    
    final class Output: ObservableObject {
        @Published var isLoginEnabled = true
        @Published var isLoading = false
        
        @Published var emailValidationMessage = ""
        @Published var passwordValidationMessage = ""
    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let output = Output()
        
        
                
        return output
    }
}
