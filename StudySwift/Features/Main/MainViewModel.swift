//
//  MainViewModel.swift
//  StudySwift
//
//  Created by Rodrigo Santos on 27/09/21.
//

import Foundation

struct MainViewModel {
    let navigator: MainNavigatorType
    let useCase: MainUseCaseType
}

extension MainViewModel: ViewModel {
    struct Input {
    }
    
    final class Output: ObservableObject {
    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let output = Output()

        return output
    }
}
