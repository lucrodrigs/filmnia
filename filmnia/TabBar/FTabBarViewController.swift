//
//  File.swift
//  filmnia
//
//  Created by Lucas Rodrigues Dias on 18/02/20.
//  Copyright © 2020 lucrodrigs. All rights reserved.
//

import UIKit

class FTabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.isTranslucent = true
        self.tabBar.barTintColor = .ColorDarkBlueDefault
        self.tabBar.unselectedItemTintColor = .ColorGrayDefault
        self.tabBar.selectedImageTintColor = .white
    }
}
