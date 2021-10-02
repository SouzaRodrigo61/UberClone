//
//  MainNavigator.swift
//  StudySwift
//
//  Created by Rodrigo Santos on 27/09/21.
//

import Foundation
import UIKit

protocol MainNavigatorType {
    func toSignUp()
}

struct MainNavigator: MainNavigatorType, ShowingSignUp {

    
    unowned let factory: Factory
    unowned let navigationController: UINavigationController
    
    func toSignUp() {
        showSignUp()
    }
    
}
