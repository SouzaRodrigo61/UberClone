//
//  MainFactory.swift
//  StudySwift
//
//  Created by Rodrigo Santos on 27/09/21.
//

import Foundation
import UIKit

protocol MainFactory {
    func resolve(navigationController: UINavigationController) -> MainViewController
    func resolve(navigationController: UINavigationController) -> MainViewModel
    func resolve(navigationController: UINavigationController) -> MainNavigatorType
    func resolve() -> MainUseCaseType
}

extension MainFactory {
    
    func resolve(navigationController: UINavigationController) -> MainViewController {
        let vc = MainViewController()
        let vm: MainViewModel = resolve(navigationController: navigationController)
        vc.bindViewModel(to: vm)
        return vc
    }
    
    func resolve(navigationController: UINavigationController) -> MainViewModel {
        return MainViewModel(
            navigator: resolve(navigationController: navigationController),
            useCase: resolve()
        )
    }
}

extension MainFactory where Self: DefaultFactory {
    func resolve(navigationController: UINavigationController) -> MainNavigatorType {
        return MainNavigator(factory: self, navigationController: navigationController)
    }
    
    func resolve() -> MainUseCaseType {
        return MainUseCase(authGateway: resolve())
    }
}
