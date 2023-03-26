//
//  LoginViewController.swift
//  TwitterCloneApp
//
//  Created by Yildirim on 10.02.2023.
//

import UIKit
import Combine
import Firebase
import FirebaseAuthCombineSwift
import FirebaseAuth

class LoginViewController: UIViewController {

    private var viewModel = AuthenticationViewViewModel()
    private var subscriptions : Set<AnyCancellable> = []
    
    private let loginLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Login Your Account"
        label.font = .systemFont(ofSize: 32, weight: .bold)
        return label
    }()
    
    private let emailTextField : UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.attributedPlaceholder = NSAttributedString(
            string: "Email",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
        
        )
        textField.keyboardType = .emailAddress
        return textField
        
    }()
    
    private let loginAccountButton : UIButton = {
        let button = UIButton(type:.system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(red: 29/255, green: 161/255, blue:242/255, alpha:1)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .regular)
        button.setTitle("Login", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 25
        button.tintColor = .white
        //button.isEnabled = false
        return button
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.attributedPlaceholder = NSAttributedString(
            string: "Password",
               attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray])
        textField.isSecureTextEntry = true
        return textField
    }()
    
    @objc private func didChangeEmailField(){
        viewModel.email = emailTextField.text
        viewModel.validateAuthenticationForm()
    }
    
    @objc private func didChangePasswordField(){
        
        viewModel.password = passwordTextField.text
        viewModel.validateAuthenticationForm()
    }
        
    private func bindViews(){
        emailTextField.addTarget(self, action: #selector(didChangeEmailField), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(didChangePasswordField), for: .editingChanged)
        viewModel.$isAuthenticationFormValid.sink { [weak self] validationState in
            self?.loginAccountButton.isEnabled = validationState
        }.store(in: &subscriptions)
        
        viewModel.$user.sink { [weak self] user in
            guard user != nil else {return}
            guard let vc = self?.navigationController?.viewControllers.first as? OnboardingViewController else {return}
            vc.dismiss(animated: true)
        }.store(in: &subscriptions)
        
        viewModel.$error.sink { [weak self] errorString in
            guard let error = errorString else{return}
            self?.presentAlert(with: error)
        }.store(in: &subscriptions)
    }
    
    private func presentAlert(with error:String){
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(okButton)
        present(alert,animated: true)
    }
    
     override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
         view.addSubview(emailTextField)
         view.addSubview(loginLabel)
         view.addSubview(passwordTextField)
         view.addSubview(loginAccountButton)
         configureConstraints()
         view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapToDismiss)))
         loginAccountButton.addTarget(self, action: #selector(loginButtonTap), for: .touchUpInside)
         bindViews()
     }
    
    @objc private func loginButtonTap(){
        viewModel.loginUser()
        
    }
    
    @objc private func didTapToDismiss(){
        view.endEditing(true)
    }
    
    private func configureConstraints(){
        let loginLabelConstraint = [
            loginLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20)
        ]
        
        let emailTextFieldConstraint = [
            emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailTextField.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 20),
            emailTextField.widthAnchor.constraint(equalToConstant: view.frame.width - 40),
            emailTextField.heightAnchor.constraint(equalToConstant: 60)
        ]
        
        let passwordTextFieldConstraint = [
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 15),
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTextField.widthAnchor.constraint(equalToConstant: view.frame.width - 40),
            passwordTextField.heightAnchor.constraint(equalToConstant: 60)
        ]
        
        let loginAccountButtonConstrait = [
            loginAccountButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            loginAccountButton.heightAnchor.constraint(equalToConstant: 50),
            loginAccountButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            loginAccountButton.widthAnchor.constraint(equalToConstant: 180)
        ]
        
        NSLayoutConstraint.activate(loginAccountButtonConstrait)
        NSLayoutConstraint.activate(loginLabelConstraint)
        NSLayoutConstraint.activate(emailTextFieldConstraint)
        NSLayoutConstraint.activate(passwordTextFieldConstraint)
        
        }

}
