//
//  MainUseCase.swift
//  StudySwift
//
//  Created by Rodrigo Santos on 27/09/21.
//

import Foundation
import Combine

protocol MainUseCaseType {
    func login(email: String, password: String) -> Observable<Void>
}

protocol AuthGatewayType {
    func login(email: String, password: String) -> Observable<Void>
}

protocol LoggingIn {
    var authGateway: AuthGatewayType { get }
}

protocol AuthFactory {
    func resolve() -> AuthGatewayType
}

extension AuthFactory where Self: DefaultFactory {

    func resolve() -> AuthGatewayType {
        AuthGateway()
    }

}


struct AuthGateway: AuthGatewayType {
    func login(email: String, password: String) -> Observable<Void> {
        
        print(email, password)
        
        return Future { promise in
            DispatchQueue.global().asyncAfter(deadline: .now() + 0.5, execute: {
                promise(.success(()))
            })
        }
        .eraseToAnyPublisher()
    }
}

extension LoggingIn {
    func login(email: String, password: String) -> Observable<Void> {

        return authGateway.login(email: email, password: password)
    }
}


struct MainUseCase: MainUseCaseType, LoggingIn {
    let authGateway: AuthGatewayType
}
