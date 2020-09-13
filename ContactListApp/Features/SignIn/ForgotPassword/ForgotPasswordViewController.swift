//
//  ForgotPasswordViewController.swift
//  ContactListApp
//
//  Created by Gerardo on 12/09/20.
//  Copyright © 2020 Gerardo. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: UIViewController {

    //MARK: Variables and Constants
    private var forgotPasswordView = ForgotPasswordView()
    
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = #colorLiteral(red: 0.4040249884, green: 0.7187735438, blue: 0.9633027911, alpha: 1)
        setUpView()
    }
    
    //MARK: Functions
    private func setUpNavigationItem() {
        navigationItem.title = "Forgot Password"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
    }
    
    private func setUpView() {
        forgotPasswordView.delegate = self
        forgotPasswordView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(forgotPasswordView)
        
        NSLayoutConstraint.activate([
            forgotPasswordView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            forgotPasswordView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            forgotPasswordView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            forgotPasswordView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            ])
    }
    
    private func sendEmail(userEmail: String?) -> Bool {
        let storedUserEmail = UserDefaults.standard.string(forKey: "userEmail")
        
        if userEmail == storedUserEmail {
            navigationController?.popViewController(animated: true)
        } else {
            forgotPasswordView.displayErrorMessage("The email does not exist")
            print("The email does not exist")
            return false
        }
        return true
    }
}

//MARK: ForgotPasswordViewDelegate
extension ForgotPasswordViewController: ForgotPasswordDelegate {
    func forgotPasswordView(_ forgotPasswordView: ForgotPasswordView, sendEmailPressed sendEmailButton: UIButton, userEmail: String?) {
        guard sendEmail(userEmail: userEmail) else {
            return
        }
    }
}
