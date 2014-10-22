//
//  FJManageViewController.swift
//  FruitJuice
//
//  Created by Phuc Dang on 10/22/14.
//  Copyright (c) 2014 Phuc Dang. All rights reserved.
//

import UIKit

class FJManageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func createJFPressed(sender: AnyObject) {
        let controller : FJAdminViewController = FJAdminViewController(nibName: "FJAdminViewController", bundle: nil)
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func orderPressed(sender: AnyObject) {
        let controller : MainViewController = MainViewController(nibName: "MainViewController", bundle: nil)
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func viewHistoryPressed(sender: AnyObject) {
    }


}
