//
//  TestFbAPI.swift
//  Daily Readings
//
//  Created by PoGo on 12/4/17.
//  Copyright © 2017 PoGo. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class TestFbAPI: UIViewController {


    let loginButton: FBSDKLoginButton = {
        let button = FBSDKLoginButton()
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(loginButton)
        loginButton.center = view.center

        // Do any additional setup after loading the view.
    }


}
