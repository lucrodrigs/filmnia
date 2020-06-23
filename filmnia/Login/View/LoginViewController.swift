//
//  LoginViewController.swift
//  filmnia
//
//  Created by Lucas Rodrigues Dias on 21/04/20.
//  Copyright © 2020 lucrodrigs. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    var viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNeedsStatusBarAppearanceUpdate()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "backgroundOriginal.jpeg")!)
        viewModel.delegateAlert = self
        viewModel.requestTokenForLogin()
        hideKeyboardWhenTappedAround()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
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

extension LoginViewController: AlertDelegate {
    
    func alertMarks(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}
