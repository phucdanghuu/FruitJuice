//
//  FJAdminViewController.swift
//  FruitJuice
//
//  Created by Phuc Dang on 10/22/14.
//  Copyright (c) 2014 Phuc Dang. All rights reserved.
//

import UIKit

class FJAdminViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var headerView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    var arrItems = [FruitModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.tableView.tableHeaderView = self.headerView
        var obj1 = FruitModel(name: "Orange", isOrdered: true, quantity: 10)
        var obj2 = FruitModel(name: "Test 1", isOrdered: true, quantity: 10)
        var obj3 = FruitModel(name: "Test 2", isOrdered: false, quantity: 10)
        
        self.arrItems.append(obj1)
        self.arrItems.append(obj2)
        self.arrItems.append(obj3)
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrItems.count + 1
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
        if(indexPath.row == self.arrItems.count){
            cell?.textLabel.text = "Add more"
            cell?.accessoryType = UITableViewCellAccessoryType.None
        }else{
            cell?.textLabel.text = self.arrItems[indexPath.row].fruitName
            cell?.accessoryType = UITableViewCellAccessoryType.Checkmark
        }
        
        return cell!
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}
