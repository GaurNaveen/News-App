//
//  LoginViewController.swift
//  News App
//
//  Created by Naveen Gaur on 12/7/19.
//  Copyright © 2019 Naveen Gaur. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var containerView: UIView!
    
    // Variables to hold the user info
    var email: String = ""
    var password: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackgroundView()
        setupContainerView()
        setupLoginButton()
        setTextFieldDelegates()
    }
    
    /// Setting up the views here.
    let backgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.init(netHex: 0x3b5998)
        return view
    }()
    
    func setupBackgroundView() {
        // Add the background view to the main view as a subview.
        view.addSubview(backgroundView)
        backgroundView.addSubview(containerView)
        containerView.addSubview(loginButton)
        // Set AutoLayout
        backgroundView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        backgroundView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        backgroundView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
    func setupContainerView(){
        containerView.dropShadow()
        containerView.layer.cornerRadius = 5
        containerView.backgroundColor = .white
    }
    
    func setupLoginButton(){
        loginButton.layer.cornerRadius = 10
        loginButton.backgroundColor = UIColor.init(netHex: 0x3b5998)
    }
    
    ///   Get Inputs from Text Fields
    func setTextFieldDelegates() {
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        // call the function to get the input
    }
    
    // When the uer clicks the login button , get the input from the text fields and validate them.
    @IBAction func loginButtonClicked(_ sender: Any) {
        if((usernameTextField.text?.isEmpty)! || (passwordTextField.text?.isEmpty)!) {
            //TODO: Present Alert here
        } else {
            print(usernameTextField.text)
            print(passwordTextField.text)
        }
    }
}

///Get the data from the text fields.
extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
