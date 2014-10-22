//
//  LoginViewController.swift
//  FruitJuice
//
//  Created by Phuc Dang on 10/21/14.
//  Copyright (c) 2014 Phuc Dang. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var userNameTxt: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var passwordTxt: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginPressed(sender: AnyObject) {
        self.getUserNameAndPassword()
    }
    func getUserNameAndPassword(){
        var userName = self.userNameTxt.text;
        var passWord = self.passwordTxt.text;
        NSUserDefaults.standardUserDefaults().setValue("abc", forKey: "session_id")
        NSUserDefaults.standardUserDefaults().synchronize()
        
        println("Username is \(userName), password: \(passWord)")
        let mainController : MainViewController = MainViewController(nibName: "MainViewController", bundle: nil)
        mainController.username = userName
        mainController.password = passWord
        self.navigationController?.pushViewController(mainController, animated: true)
    }
}
