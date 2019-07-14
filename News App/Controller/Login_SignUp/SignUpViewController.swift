//
//  SignUpViewController.swift
//  News App
//
//  Created by Naveen Gaur on 13/7/19.
//  Copyright © 2019 Naveen Gaur. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var signUpLabel: UILabel!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var reenterPasswordTextField: UITextField!
    
    // Variable to hold the user info. Make this a dictionary.
    var firstName: String = ""
    var lastName: String = ""
    var email: String = ""
    var password: String = ""
    var rePassword: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupAutoLayout()
    }
    
    /// Labels and Text Fields setup here.
    func setupTextFieldsDelegate(){
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        emailTextField.delegate = self
        reenterPasswordTextField.delegate = self
    }
    
    // Sets the auto layout for the 'sign up' label at the top of the screen.
    func setupAutoLayout(){
        signUpLabel.translatesAutoresizingMaskIntoConstraints = false
        signUpLabel.topAnchor.constraint(equalTo: view.topAnchor, constant:100).isActive = true
        signUpLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 141).isActive = true
        signUpLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 131).isActive = true
        signUpLabel.heightAnchor.constraint(equalToConstant: 37).isActive = true
    }
    
    /// Get the data from the text fields
    @IBAction func signUpButton(_ sender: Any) {
        
        // Check if they are empty.
        if((firstNameTextField.text?.isEmpty)! || (lastNameTextField.text?.isEmpty)! || (emailTextField.text?.isEmpty)! || (reenterPasswordTextField.text?.isEmpty)! || (passwordTextField.text?.isEmpty)!) {
            //TODO: Display Alert
        } else {
            // Retrieve data from the text fields, validate and then allow the user to go to the main news page.
            firstName = firstNameTextField.text!
            lastName = lastNameTextField.text!
            email = emailTextField.text!
            password = passwordTextField.text!
            rePassword = reenterPasswordTextField.text!
        }
    }
}

extension SignUpViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
