//
//  MainViewController.swift
//  FruitJuice
//
//  Created by Phuc Dang on 10/21/14.
//  Copyright (c) 2014 Phuc Dang. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var headerView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var openTimeLbl: UILabel!
    @IBOutlet weak var closeTimeLbl: UILabel!
    var username: String = ""
    var password: String = ""
    var arrItems = [FruitModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationItem.setRightBarButtonItem(UIBarButtonItem(title: "Logout", style: UIBarButtonItemStyle.Plain, target: self, action: "logoutPressed:"), animated: true)

        self.title = "Fruit Juices"
        self.tableView.tableHeaderView = self.headerView
        println("Username is \(self.username) and password: \(self.password)")
        var obj1 = FruitModel(name: "Orange", isOrdered: true, quantity: 10)
        var obj2 = FruitModel(name: "Test 1", isOrdered: true, quantity: 10)
        var obj3 = FruitModel(name: "Test 2", isOrdered: false, quantity: 10)
        self.arrItems.append(obj1)
        self.arrItems.append(obj2)
        self.arrItems.append(obj3)
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableView.reloadData()
        
    }
    func logoutPressed(sender: UIBarButtonItem) {
        println("logout pressed")
        NSUserDefaults.standardUserDefaults().setValue("", forKey: "session_id")
        NSUserDefaults.standardUserDefaults().setValue(false, forKey: "is_admin")
        NSUserDefaults.standardUserDefaults().synchronize()
        NSNotificationCenter.defaultCenter().postNotificationName("logout_notification", object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrItems.count
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    // MARK: - Table view delegate
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell? = tableView.dequeueReusableCellWithIdentifier("cell") as? UITableViewCell
        if (cell != nil)
        {
            cell = UITableViewCell(style: UITableViewCellStyle.Subtitle,
                reuseIdentifier: "cell")
        }
        
        var currentFruit:FruitModel = self.arrItems[indexPath.row]
        cell?.textLabel.text = currentFruit.fruitName
        cell?.detailTextLabel?.text = "Quantity: \(currentFruit.fruitQuantity)"
        cell?.accessoryType = currentFruit.isOrdered == true ? UITableViewCellAccessoryType.Checkmark : UITableViewCellAccessoryType.None
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("You selected cell: \(self.arrItems[indexPath.row].fruitName)!")
        let detailController : FruitDetailViewController = FruitDetailViewController(nibName: "FruitDetailViewController", bundle: nil)
        self.navigationController?.pushViewController(detailController, animated: true)
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50.0
    }

}
