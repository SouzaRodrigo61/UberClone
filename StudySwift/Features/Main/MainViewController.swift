//
//  MainViewController.swift
//  StudySwift
//
//  Created by Rodrigo Santos on 27/09/21.
//

import Combine
import UIKit

final class MainViewController: UIViewController, Bindable {
    
    // MARK: - Variables
    var viewModel: MainViewModel!
    
    private let loginTrigger = PassthroughSubject<Void, Never>()
    private let signUpTrigger = PassthroughSubject<Void, Never>()
    private let loginNavTrigger = PassthroughSubject<Void, Never>()
    
    private var input: MainViewModel.Input!
    private var output: MainViewModel.Output!
    
    private let cancelBag = CancelBag()
    private var bindings = Set<AnyCancellable>()
    
    
    // MARK: - Properties
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "UBER"
        label.font = UIFont(name: UIFont.AvenirLight, size: 36)
        label.textColor = UIColor(white: 1, alpha: 0.8)
        return label
    }()
    
    private lazy var emailContainerView: UIView = {
        let view = UIView().inputContainerView(image: #imageLiteral(resourceName: "ic_mail_outline_white_2x"), textField: emailTextField)
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return view
    }()
    
    private lazy var emailTextField: UITextField = {
        let tf = UITextField().textField(withPlaceholder: "Email",
                                         withKeyboardType: .emailAddress)
        return tf
    }()
    
    private lazy var passwordContainerView: UIView = {
        let view = UIView().inputContainerView(image: #imageLiteral(resourceName: "ic_lock_outline_white_2x.png"), textField: passwordTextField)
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return view
    }()
    
    private lazy var passwordTextField: UITextField = {
        let tf =  UITextField().textField(withPlaceholder: "Password",
                                          isSecureTextEntry: true)
        return tf
    }()
    
    private lazy var StackForm: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [emailContainerView, passwordContainerView])
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 16
        return stack
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(UIColor(white: 1, alpha: 0.5), for: .normal)
        button.backgroundColor = .mainBlueTint
        button.layer.cornerRadius = 5
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(handleShowSignIn), for: .touchUpInside)
        return button
    }()
    
    private let dontHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        
        let attributedTitle = NSMutableAttributedString(string: "Don't have an account? ",
                                                        attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        attributedTitle.append(NSAttributedString(string: "Sign Up", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.mainBlueTint]))
        
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Bind ViewModel
    
    func bindViewModel() {
        let input = MainViewModel.Input(loginTrigger: loginTrigger.asDriver(),
                                        signUpTrigger: signUpTrigger.asDriver(),
                                        loginNavTrigger: loginNavTrigger.asDriver())
        output = viewModel.transform(input, cancelBag: cancelBag)
        self.input = input
        
        emailTextField.textPublisher
            .receive(on: DispatchQueue.main)
            .assign(to: \.email, on: input)
            .store(in: cancelBag)
        
        passwordTextField.textPublisher
            .receive(on: DispatchQueue.main)
            .assign(to: \.password, on: input)
            .store(in: cancelBag)
        
        output.$isLoginEnabled
            .sink { isLoginEnabled in
                self.loginButton.isEnabled = isLoginEnabled
            }
            .store(in: cancelBag)
        
        
        
        output.$alert
            .sink { alertOutput in
                let alert = UIAlertController(title: alertOutput.title,
                                              message: alertOutput.message,
                                              preferredStyle: .alert)
                
                DispatchQueue.main.async {
                    if alertOutput.isShowing == true {
                        self.present(alert, animated: true, completion: nil)
                    }
                }
                
                let deadlineTime = DispatchTime.now() + .seconds(2)
                
                DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
                    alert.dismiss(animated: true, completion: nil)
                    
                    if alertOutput.isShowing == true {
                        self.output.$isSuccess
                            .sink { isSuccess in
                                if isSuccess == true {
                                    self.loginNavTrigger.send(())
                                }
                            }
                            .store(in: self.cancelBag)
                    }
                }
                
            }
            .store(in: cancelBag)
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

extension MainViewController {
    
    @objc func handleShowSignUp() {
        self.signUpTrigger.send(())
    }
    
    @objc func handleShowSignIn() {
        self.loginTrigger.send(())
    }
}


// MARK: - Configuration UI

extension MainViewController {
    func setupUI() {
        
        view.backgroundColor = UIColor.BackgroundColor
        
        view.addSubview(titleLabel)
        titleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor)
        titleLabel.centerX(inView: view)
        
        view.addSubview(StackForm)
        StackForm.anchor(top: titleLabel.bottomAnchor,
                         left: view.leftAnchor,
                         right: view.rightAnchor,
                         paddingTop: 40,
                         paddingLeft: 16,
                         paddingRight: 16)
        
        view.addSubview(loginButton)
        loginButton.anchor(top: StackForm.bottomAnchor,
                           left: view.leftAnchor,
                           right: view.rightAnchor,
                           paddingTop: 40,
                           paddingLeft: 16,
                           paddingRight: 16)
        
        view.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.centerX(inView: view)
        dontHaveAccountButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, height: 32)
        
    }
}
