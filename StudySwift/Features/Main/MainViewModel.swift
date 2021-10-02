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
        
        let loginTrigger: Driver<Void>
        let signUpTrigger: Driver<Void>
        let loginNavTrigger: Driver<Void>
        
        init(loginTrigger: Driver<Void>,
             signUpTrigger: Driver<Void>,
             loginNavTrigger: Driver<Void>) {
            self.loginTrigger = loginTrigger
            self.signUpTrigger = signUpTrigger
            self.loginNavTrigger = loginNavTrigger
        }
        
    }
    
    final class Output: ObservableObject {
        @Published var isLoginEnabled = true
        @Published var isLoading = false
        @Published var isSuccess = false
        @Published var alert = AlertMessage()
        @Published var emailValidationMessage = ""
        @Published var passwordValidationMessage = ""
    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        
        let errorTracker = ErrorTracker()
        let activityTracker = ActivityTracker(false)
        let output = Output()
        
        input.loginTrigger
            .delay(for: 0.1, scheduler: RunLoop.main)  // waiting for username/password validation
            .filter { output.isLoginEnabled }
            .map { _ in
                self.useCase.login(email: input.email, password: input.password)
                    .trackError(errorTracker)
                    .trackActivity(activityTracker)
                    .asDriver()
            }
            .switchToLatest()
            .sink(receiveValue: {
                output.isLoginEnabled.toggle()
                let message = AlertMessage(title: "Login successful",
                                           message: "Hello \(input.email). Welcome to the app!",
                                           isShowing: true)
                output.alert = message
                output.isSuccess = true
            })
            .store(in: cancelBag)
        
        
        input.signUpTrigger
            .handleEvents(receiveOutput: { _ in
                self.navigator.toSignUp()
            })
            .sink()
            .store(in: cancelBag)
        
        input.loginNavTrigger
            .handleEvents(receiveOutput: { _ in
                self.navigator.toSignUp()
            })
            .sink()
            .store(in: cancelBag)
        
        errorTracker
            .receive(on: RunLoop.main)
            .map { AlertMessage(error: $0) }
            .assign(to: \.alert, on: output)
            .store(in: cancelBag)
        
        activityTracker
            .receive(on: RunLoop.main)
            .assign(to: \.isLoading, on: output)
            .store(in: cancelBag)
        
        return output
    }
}
