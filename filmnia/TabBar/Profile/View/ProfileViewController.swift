//
//  ProfileViewController.swift
//  filmnia
//
//  Created by UserTQI on 16/03/20.
//  Copyright © 2020 lucrodrigs. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var viewModel = LoginViewModel()
    
    @IBOutlet weak var password: UITextField?
    @IBOutlet weak var username: UITextField?
    
    @IBAction func requestbtn(_ sender: UIButton) {
        print("apertei o botao")
        let user: String? = username?.text
        let pass: String? = password?.text
        viewModel.validateForLogin(username: user!, password: pass!)
    }
    
    

   
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
