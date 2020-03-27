//
//  AuthViewController.swift
//  VKontakteFeed
//
//  Created by Виктор on 24.03.2020.
//  Copyright © 2020 Виктор. All rights reserved.
//

import UIKit

class AuthViewController: UIViewController {
   
    private var authService: AuthService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        authService = AppDelegate.shared().authService
    }
    
    
    
    @IBAction func authButton() {
        authService.wakeUpSession()
    }

    

}
