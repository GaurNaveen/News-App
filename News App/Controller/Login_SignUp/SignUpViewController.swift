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
    
    @IBOutlet weak var reenterPasswordTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
       
    }
    
    func setupTextFieldsDelegate(){
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        emailTextField.delegate = self
        reenterPasswordTextField.delegate = self
    
    }
    
}

extension SignUpViewController: UITextFieldDelegate {
    
}
