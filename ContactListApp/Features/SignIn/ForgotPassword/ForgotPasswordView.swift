//
//  ForgotPasswordView.swift
//  ContactListApp
//
//  Created by Gerardo on 12/09/20.
//  Copyright © 2020 Gerardo. All rights reserved.
//

import UIKit

protocol ForgotPasswordDelegate: AnyObject {
    func forgotPasswordView(_ forgotPasswordView: ForgotPasswordView, sendEmailPressed sendEmailButton: UIButton, userEmail: String?)
}

class ForgotPasswordView: UIView {
    //MARK: Variables and Constants
    weak var delegate: ForgotPasswordDelegate?
    
    private weak var activeTextField: UITextField?
    
    lazy var logoimageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .gray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var alertMessage: UILabel = {
        let message = UILabel()
        message.text = ""
        message.textColor = .red
        message.textAlignment = .center
        message.numberOfLines = 2
        message.translatesAutoresizingMaskIntoConstraints = false
        return message
    }()
    
    lazy var sendEmailTextField: UITextField = {
        let email = UITextField()
        email.placeholder = "Email"
        email.backgroundColor = .white
        email.keyboardType = .emailAddress
        email.borderStyle = .roundedRect
        email.delegate = self
        email.translatesAutoresizingMaskIntoConstraints = false
        
        return email
    }()
    
    lazy var sendEmailButton: UIButton = {
        let sendEmail = UIButton()
        sendEmail.setTitle("SEND EMAIL", for: .normal)
        sendEmail.setTitleColor(.white, for: .normal)
        sendEmail.backgroundColor = #colorLiteral(red: 0.1105268672, green: 0.4639024138, blue: 0.8267809749, alpha: 1)
        sendEmail.layer.cornerRadius = 5
        sendEmail.addTarget(self, action: #selector(sendEmailButtonPressed), for: .touchUpInside)
        sendEmail.translatesAutoresizingMaskIntoConstraints = false
        return sendEmail
    }()
    
    //MARK: Life Cycle
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    //MARK: Functions
    func displayErrorMessage(_ message: String) {
        alertMessage.text = message
    }
    func setupLayout() {
        backgroundColor = #colorLiteral(red: 0.4040249884, green: 0.7187735438, blue: 0.9633027911, alpha: 1)
        addSubview(logoimageView)
        addSubview(alertMessage)
        addSubview(sendEmailTextField)
        addSubview(sendEmailButton)
        
        logoimageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        logoimageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        logoimageView.heightAnchor.constraint(equalToConstant: 180).isActive = true
        logoimageView.widthAnchor.constraint(equalToConstant: 180).isActive = true
        
        alertMessage.topAnchor.constraint(equalTo: logoimageView.bottomAnchor, constant: 20).isActive = true
        alertMessage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        alertMessage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
    
        sendEmailTextField.topAnchor.constraint(equalTo: alertMessage.bottomAnchor, constant: 10).isActive = true
        sendEmailTextField.leadingAnchor.constraint(equalTo: alertMessage.leadingAnchor).isActive = true
        sendEmailTextField.trailingAnchor.constraint(equalTo: alertMessage.trailingAnchor).isActive = true
        
        sendEmailButton.topAnchor.constraint(equalTo: sendEmailTextField.bottomAnchor, constant: 20).isActive = true
        sendEmailButton.leadingAnchor.constraint(equalTo: sendEmailTextField.leadingAnchor).isActive = true
        sendEmailButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
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
    @objc private func sendEmailButtonPressed() {
        let userEmail = sendEmailTextField.text
        delegate?.forgotPasswordView(self, sendEmailPressed: sendEmailButton, userEmail: userEmail)
    }
}

//MARK: UITextFieldDelegate
extension ForgotPasswordView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        moveTextField(textField, moveDistance: -5, up: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        moveTextField(textField, moveDistance: -5, up: false)
    }
}

