//
//  SignUpViewModel.swift
//  StudySwift
//
//  Created by Rodrigo Santos on 01/10/21.
//

import Foundation
import Combine

struct SignUpViewModel {
    let navigator: MainNavigatorType
    let useCase: MainUseCaseType
}

extension SignUpViewModel: ViewModel {
    final class Input {
        init() {}
        
    }
    
    final class Output: ObservableObject {
        init() {}
        
    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        
        let output = Output()
        
        
        return output
    }
}
