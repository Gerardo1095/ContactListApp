//
//  RegisterViewController.swift
//  ContactListApp
//
//  Created by Gerardo on 12/09/20.
//  Copyright © 2020 Gerardo. All rights reserved.
//

import UIKit

final class RegisterViewController: UIViewController{
    
    //MARK: Variables and Constants
    private let registerView = RegisterView()
    
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavigationItem()
        setUpView()
    }
    
    //MARK: Functions
    private func setUpNavigationItem() {
        navigationItem.title = "Sign up"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
    }
    
    private func setUpView() {
        registerView.delegate = self
        registerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(registerView)
        
        NSLayoutConstraint.activate([
            registerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            registerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            registerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            registerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    private func validateInputs(user: String?, password: String?, repeatPassword: String?) -> Bool {
        if user == "" {
            registerView.displayErrorMessage("Please enter an Email")
            return false
        } else if !isValidEmail(user!) {
            registerView.displayErrorMessage("Invalid email")
            return false
        } else if password == "" {
            registerView.displayErrorMessage("Please enter a password")
            return false
        } else if repeatPassword == "" {
            registerView.displayErrorMessage("You need to verify your password")
            return false
        } else if password != repeatPassword {
            registerView.displayErrorMessage("Passwords do not match")
            return false
        }
        
        return true
    }
    
    private func savingUser(user: String?, with password: String?) -> Bool {
        UserDefaults.standard.set(user, forKey: "userEmail")
        UserDefaults.standard.set(password, forKey: "userPassword")
        UserDefaults.standard.synchronize()
        return true
    }
    
    private func registerSucessFul() {
        self.navigationController?.popViewController(animated: true)
    }
}

//MARK: RegisterViewDelegate
extension RegisterViewController: RegisterViewDelegate {
    func registerView(_ view: RegisterView, registerPressed button: UIButton, user: String?, password: String?, repeatedPassword: String?) {
        if validateInputs(user: user, password: password, repeatPassword: repeatedPassword) {
            print("Register Succesful")
        }
    }
    
    func registerView(_ view: RegisterView, termsAndConditionsPressed button: UIButton) {
    }
    
    func registerView(_ view: RegisterView, termsAndConditionsTapped label: UILabel) {
    }
    
}
