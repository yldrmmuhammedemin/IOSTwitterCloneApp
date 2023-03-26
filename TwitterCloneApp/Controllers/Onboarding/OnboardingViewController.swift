//
//  OnboardingViewController.swift
//  TwitterCloneApp
//
//  Created by Yildirim on 9.02.2023.
//

import UIKit

class OnboardingViewController: UIViewController {
   
    private let createAccountButton:UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Create account", for:  .normal)
        button.tintColor = .white
        button.layer.masksToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 22, weight: .bold)
        button.backgroundColor = UIColor(red: 29/255, green: 161/255, blue:242/255, alpha:1)
        button.layer.cornerRadius = 30
        return button
    }()
        
    @objc private func didTapCreateAccountButton (){
        let vc = RegisterViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func didTapLoginButton(){
        let vc = LoginViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
    private let welcomeLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "See what's hapenning in the world right now."
        label.font = .systemFont(ofSize: 32, weight: .heavy)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = UIColor(red: 29/255, green: 161/255, blue:242/255, alpha:1)
        button.titleLabel?.font = .systemFont(ofSize: 14)
        button.setTitle("Login", for: .normal)
        return button
    }()
    
    private let promptLabel: UILabel = {
        let label = UILabel()
        label.tintColor = .gray
        label.text = "Have an already account already ?"
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(welcomeLabel)
        view.addSubview(createAccountButton)
        view.addSubview(promptLabel)
        view.addSubview(loginButton)
        view.backgroundColor = .systemBackground
        loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        createAccountButton.addTarget(self, action: #selector(didTapCreateAccountButton), for: .touchUpInside)
        configureConstraints()
    }
    
 
    private func configureConstraints (){
        
        let welcomeLabelConstraint = [
            welcomeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            welcomeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            welcomeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ]
        
        let createAccountButtonConstraint = [
            createAccountButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            createAccountButton.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 20),
            createAccountButton.widthAnchor.constraint(equalTo: welcomeLabel.widthAnchor, constant: -20),
            createAccountButton.heightAnchor.constraint(equalToConstant: 60)
        ]
        
        let promptLabelConstraint = [
            promptLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            promptLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60)
        ]
        
        let loginButtonConstraint = [
            loginButton.leadingAnchor.constraint(equalTo: promptLabel.trailingAnchor, constant: 10),
            loginButton.centerYAnchor.constraint(equalTo: promptLabel.centerYAnchor)
        ]
        

        NSLayoutConstraint.activate(welcomeLabelConstraint)
        NSLayoutConstraint.activate(createAccountButtonConstraint)
        NSLayoutConstraint.activate(promptLabelConstraint)
        NSLayoutConstraint.activate(loginButtonConstraint)
        
        
    }
}
