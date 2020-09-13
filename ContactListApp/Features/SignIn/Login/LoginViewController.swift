//
//  LoginViewController.swift
//  ContactListApp
//
//  Created by Gerardo on 12/09/20.
//  Copyright © 2020 Gerardo. All rights reserved.
//

import UIKit

final class LoginViewController: UIViewController {
    
    //MARK: Variables and Constants
    private let loginView = LoginView()
    
    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationItem()
        setUpView()
    }
    
    //MARK: Functions
    private func setUpNavigationItem() {
        navigationItem.title = "Login"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
    }
    
    private func setUpView() {
        loginView.delegate = self
        
        loginView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loginView)
        
        NSLayoutConstraint.activate([
            loginView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            loginView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            loginView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            loginView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            ])
    }
    
    private func validateInput(userName: String?, password: String?) -> Bool {
        if userName == "" {
            loginView.displayErrorMessage("Please enter an Email")
            return false
        }else if !isValidEmail(userName!) {
            loginView.displayErrorMessage("Invalid email")
            return false
        } else if password == "" {
            loginView.displayErrorMessage("Please enter a password")
            return false
        }
        
        return true
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    private func validateUserExistance(userName: String?, password: String?) -> Bool {
        guard let user = userName, let password = password else { return false }
        let storedEmail = UserDefaults.standard.string(forKey: "userEmail")
        let storedPassword = UserDefaults.standard.string(forKey: "userPassword")
        
        if user != storedEmail && password != storedPassword {
            loginView.displayErrorMessage("Invalid user or password")
            return false
        }
        return true
    }
    
    private func moveToHome() {
        print("Logged")
    }
}

//MARK: LoginViewDelegate
extension LoginViewController: LoginViewDelegate {
    func loginView(_ loginView: LoginView, loginPressed loginButton: UIButton, userName: String?, password: String?) {
        guard validateInput(userName: userName, password: password) else { return }
        guard validateUserExistance(userName: userName, password: password) else { return }
        
        moveToHome()
        
    }
    
    func loginView(_ loginView: LoginView, signUpPressed signUpButton: UIButton) {
        let registerViewController = RegisterViewController()
        navigationController?.pushViewController(registerViewController, animated: true)
    }
    
    func loginView(_ loginView: LoginView, forgotPasswordPressed forgotPasswordButton: UIButton) {
        let forgot = ForgotPasswordViewController()
        navigationController?.pushViewController(forgot, animated: true)
    }
}
