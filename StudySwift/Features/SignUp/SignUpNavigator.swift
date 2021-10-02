//
//  SignUpNavigator.swift
//  StudySwift
//
//  Created by Rodrigo Santos on 01/10/21.
//

import Foundation
import UIKit

protocol SignUpNavigatorType { }

struct SignUpNavigator: SignUpNavigatorType {
    unowned let factory: Factory
    unowned let navigationController: UINavigationController
    
}
