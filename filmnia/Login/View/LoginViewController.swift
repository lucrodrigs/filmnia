//
//  LoginViewController.swift
//  filmnia
//
//  Created by UserTQI on 21/04/20.
//  Copyright © 2020 lucrodrigs. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    var viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "backgroundOriginal.jpeg")!)
        viewModel.delegate = self
        viewModel.requestTokenForLogin()
        hideKeyboardWhenTappedAround()
    }
    
    func Login() {
        let user: String? = username.text
        let pass: String? = password.text
        viewModel.validateForLogin(username: user ?? "", password: pass ?? "")
    }
    
    @IBAction func clickLogin(_ sender: UIButton) {
        Login()
    }
    
}

extension LoginViewController: LoginViewDelegate {
    
    func erroLogin(error: Error) {
        print("ERROR NO LOGIN")
    }
    
}
