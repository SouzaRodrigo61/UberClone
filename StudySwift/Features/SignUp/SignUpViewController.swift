//
//  SignUpViewController.swift
//  StudySwift
//
//  Created by Rodrigo Santos on 01/10/21.
//

import UIKit
import Combine

class SignUpViewController: UIViewController, Bindable {
    
    // MARK: - Variables
    var viewModel: SignUpViewModel!
    
    private var input: SignUpViewModel.Input!
    private var output: SignUpViewModel.Output!
    
    private let cancelBag = CancelBag()
    
    // MARK: - Properties
    
    
    
    // MARK: - Bind ViewModel
    
    func bindViewModel() {
        let input = SignUpViewModel.Input()
        output = viewModel.transform(input, cancelBag: cancelBag)
        self.input = input
    }
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}


// MARK: - Selectors

extension SignUpViewController {
    
}


// MARK: - Configuration UI

extension SignUpViewController {
    func setupUI() {
        
    }
}

