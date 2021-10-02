//
//  SignUpFactory.swift
//  StudySwift
//
//  Created by Rodrigo Santos on 01/10/21.
//

import Foundation
import UIKit


protocol SignUpFactory {
    func resolve(navigationController: UINavigationController) -> SignUpViewController
    func resolve(navigationController: UINavigationController) -> SignUpViewModel
    func resolve(navigationController: UINavigationController) -> SignUpNavigatorType
    func resolve() -> SignUpUseCaseType
}

extension SignUpFactory {
    
}

extension SignUpFactory where Self: DefaultFactory {
    func resolve(navigationController: UINavigationController) -> SignUpNavigatorType {
        return SignUpNavigator(factory: self, navigationController: navigationController)
    }
    
    func resolve() -> SignUpUseCaseType {
        return SignUpUseCase()
    }
}

