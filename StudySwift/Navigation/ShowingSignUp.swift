//
//  ShowingSignUp.swift
//  StudySwift
//
//  Created by Rodrigo Santos on 01/10/21.
//

import Foundation
import UIKit

protocol ShowingSignUp {
    var factory: Factory { get }
    var navigationController: UINavigationController { get }
}

extension ShowingSignUp {
    
    func showSignUp() {
        let view: MainViewController = factory.resolve(navigationController: navigationController)
        
        navigationController.pushViewController(view, animated: true)
    }
}
