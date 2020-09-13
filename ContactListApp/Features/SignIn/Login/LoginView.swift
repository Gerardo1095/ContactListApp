//
//  LoginView.swift
//  ContactListApp
//
//  Created by Gerardo on 12/09/20.
//  Copyright © 2020 Gerardo. All rights reserved.
//

import UIKit

protocol LoginViewDelegate: AnyObject {
    func loginView(_ loginView: LoginView, loginPressed loginButton: UIButton, userName: String?, password: String?)
    func loginView(_ loginView: LoginView, signUpPressed signUpButton: UIButton)
    func loginView(_ loginView: LoginView, forgotPasswordPressed forgotPasswordButton: UIButton)
}

final class LoginView: UIView {
    
    //MARK: Constans and Variables
    
    weak var delegate: LoginViewDelegate?
    
    private let logoimageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .gray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private let alertLabel: UILabel = {
        let errorLabel = UILabel()
        errorLabel.textColor = .red
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        return errorLabel
    }()
    
    private lazy var loginTextField: UITextField = {
        let logingTextField = UITextField()
        logingTextField.placeholder = "Usuario"
        logingTextField.backgroundColor = .white
        logingTextField.keyboardType = .emailAddress
        logingTextField.borderStyle = .roundedRect
        logingTextField.delegate = self
        logingTextField.translatesAutoresizingMaskIntoConstraints = false
        
        return logingTextField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let passwordTextField = UITextField()
        passwordTextField.placeholder = "Password"
        passwordTextField.backgroundColor = .white
        passwordTextField.isSecureTextEntry = true
        passwordTextField.keyboardType = .emailAddress
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.delegate = self
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        
        return passwordTextField
    }()
    
    private lazy var loginButton: UIButton = {
        let loginButton = UIButton()
        loginButton.setTitle("Loging", for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.backgroundColor = #colorLiteral(red: 0.1105268672, green: 0.4639024138, blue: 0.8267809749, alpha: 1)
        loginButton.layer.cornerRadius = 5
        loginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        return loginButton
    }()
    
    private lazy var signUpButton: UIButton = {
        let signUp = UIButton()
        signUp.setTitle("Sign Up!", for: .normal)
        signUp.setTitleColor(.white, for: .normal)
        signUp.translatesAutoresizingMaskIntoConstraints = false
        signUp.addTarget(self, action: #selector(signUpButtonPressed), for: .touchUpInside)
        return signUp
    }()
    
    private lazy var forgotButton: UIButton = {
        let forgot = UIButton()
        forgot.setTitle("Forgot Password?", for: .normal)
        forgot.setTitleColor(.white, for: .normal)
        forgot.addTarget(self, action: #selector(forgotPasswordButtonPressed), for: .touchUpInside)
        forgot.translatesAutoresizingMaskIntoConstraints = false
        return forgot
    }()
    
    //MARK: View life cycle
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK: Functions
    func setupLayout() {
        
        backgroundColor = #colorLiteral(red: 0.4040249884, green: 0.7187735438, blue: 0.9633027911, alpha: 1)
        
        addSubview(logoimageView)
        addSubview(alertLabel)
        addSubview(loginTextField)
        addSubview(passwordTextField)
        addSubview(loginButton)
        addSubview(signUpButton)
        addSubview(forgotButton)
        
        NSLayoutConstraint.activate([
            logoimageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 50),
            logoimageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            logoimageView.heightAnchor.constraint(equalToConstant: 180),
            logoimageView.widthAnchor.constraint(equalToConstant: 180),
            
            alertLabel.topAnchor.constraint(equalTo: logoimageView.bottomAnchor, constant: 50),
            alertLabel.heightAnchor.constraint(equalToConstant: 20),
            alertLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            alertLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            loginTextField.topAnchor.constraint(equalTo: alertLabel.bottomAnchor, constant: 10),
            loginTextField.leadingAnchor.constraint(equalTo: alertLabel.leadingAnchor),
            loginTextField.trailingAnchor.constraint(equalTo: alertLabel.trailingAnchor),
            
            passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 10),
            passwordTextField.leadingAnchor.constraint(equalTo: loginTextField.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: loginTextField.trailingAnchor),
            
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 30),
            loginButton.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor),
            loginButton.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: 40),
            
            signUpButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 7),
            signUpButton.leadingAnchor.constraint(equalTo: loginButton.leadingAnchor),
            
            forgotButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 7),
            forgotButton.trailingAnchor.constraint(equalTo: loginButton.trailingAnchor)
            ])
        
    }
    
    func displayErrorMessage(_ message: String) {
        alertLabel.text = message
    }
    
    func moveTextField(_ textField: UITextField, moveDistance: Int, up: Bool) {
        let moveDuration = 0.3
        let movement: CGFloat = CGFloat(up ? moveDistance : -moveDistance)
        UIView.beginAnimations("animateTextField", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(moveDuration)
        self.frame = frame.offsetBy(dx: 0, dy: movement)
        UIView.commitAnimations()
    }
    
    //MARK: Actions
    
    @objc private func loginButtonPressed() {
        let userEmail = loginTextField.text
        let password = passwordTextField.text
        
        delegate?.loginView(self, loginPressed: loginButton, userName: userEmail, password: password)
    }
    
    @objc private func signUpButtonPressed() {
        delegate?.loginView(self, signUpPressed: signUpButton)
    }
    
    @objc private func forgotPasswordButtonPressed() {
        delegate?.loginView(self, forgotPasswordPressed: forgotButton)
    }
}

//MARK: UITextfieldDelegate
extension LoginView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        moveTextField(textField, moveDistance: -15, up: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        moveTextField(textField, moveDistance: -15, up: false)
    }
}
