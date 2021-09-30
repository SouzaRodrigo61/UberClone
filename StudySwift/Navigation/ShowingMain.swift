//
//  ShowingMain.swift
//  StudySwift
//
//  Created by Rodrigo Santos on 29/09/21.
//

import Foundation
import UIKit

protocol ShowingMain {
    var factory: Factory { get }
    var navigationController: UINavigationController { get }
    
    func showMain()
}

extension ShowingMain {
    
    func showMain() {
        let view: MainViewController = factory.resolve(navigationController: navigationController)
        
        let vc = UINavigationController(rootViewController: view)
        navigationController.pushViewController(vc, animated: true)
    }
}
