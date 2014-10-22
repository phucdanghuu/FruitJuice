//
//  FJAdminViewController.swift
//  FruitJuice
//
//  Created by Phuc Dang on 10/22/14.
//  Copyright (c) 2014 Phuc Dang. All rights reserved.
//

import UIKit

class FJAdminViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var openTimeTxt: UITextField!
    @IBOutlet weak var closeTimeTxt: UITextField!
    var datePicker:UIDatePicker!;
    var openTimePicker:UIDatePicker!;
    var closeTimePicker:UIDatePicker!;
    
    @IBOutlet weak var dateTxt: UITextField!
    @IBOutlet var headerView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    var arrItems = [FruitModel]()
    var arrSelectedItems = [FruitModel]();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        //init date picker
        var customView:UIView = UIView (frame: CGRectMake(0, 100, 320, 160));
        customView.backgroundColor = UIColor.whiteColor();
        datePicker = UIDatePicker(frame: CGRectMake(0, 0, 320, 160));
        datePicker.datePickerMode = UIDatePickerMode.Date
        customView .addSubview(datePicker);
        dateTxt.inputView = customView;
        var doneButton:UIButton = UIButton (frame: CGRectMake(100, 100, 100, 44));
        doneButton.setTitle("Done", forState: UIControlState.Normal)
        doneButton.addTarget(self, action: "datePickerSelected", forControlEvents: UIControlEvents.TouchUpInside);
        doneButton.backgroundColor = UIColor .lightGrayColor();
        dateTxt.inputAccessoryView = doneButton;
        
        //init open time picker
        var customView1:UIView = UIView (frame: CGRectMake(0, 100, 320, 160));
        customView1.backgroundColor = UIColor.whiteColor();
        openTimePicker = UIDatePicker(frame: CGRectMake(0, 0, 320, 160));
        openTimePicker.datePickerMode = UIDatePickerMode.Time
        customView1 .addSubview(openTimePicker);
        openTimeTxt.inputView = customView1;
        var openTimeDoneButton:UIButton = UIButton (frame: CGRectMake(100, 100, 100, 44));
        openTimeDoneButton.setTitle("Done", forState: UIControlState.Normal)
        openTimeDoneButton.addTarget(self, action: "openTimePickerSelected", forControlEvents: UIControlEvents.TouchUpInside);
        openTimeDoneButton.backgroundColor = UIColor .lightGrayColor();
        openTimeTxt.inputAccessoryView = openTimeDoneButton;
        
        //init close time picker
        var customView2:UIView = UIView (frame: CGRectMake(0, 100, 320, 160));
        customView2.backgroundColor = UIColor.whiteColor();
        closeTimePicker = UIDatePicker(frame: CGRectMake(0, 0, 320, 160));
        closeTimePicker.datePickerMode = UIDatePickerMode.Time
        customView2 .addSubview(closeTimePicker);
        closeTimeTxt.inputView = customView2;
        var closeTimeDoneButton:UIButton = UIButton (frame: CGRectMake(100, 100, 100, 44));
        closeTimeDoneButton.setTitle("Done", forState: UIControlState.Normal)
        closeTimeDoneButton.addTarget(self, action: "closeTimePickerSelected", forControlEvents: UIControlEvents.TouchUpInside);
        closeTimeDoneButton.backgroundColor = UIColor .lightGrayColor();
        closeTimeTxt.inputAccessoryView = closeTimeDoneButton;
        
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
    
    func datePickerSelected()
    {
        dateTxt.resignFirstResponder()
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateTxt.text = dateFormatter.stringFromDate(datePicker.date)
    }
    
    func openTimePickerSelected()
    {
        openTimeTxt.resignFirstResponder()
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        openTimeTxt.text = dateFormatter.stringFromDate(openTimePicker.date)
    }
    
    func closeTimePickerSelected()
    {
        closeTimeTxt.resignFirstResponder()
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        closeTimeTxt.text = dateFormatter.stringFromDate(closeTimePicker.date)
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
            cell?.detailTextLabel?.text = "\(self.arrItems[indexPath.row].fruitQuantity)"
            cell?.accessoryType = UITableViewCellAccessoryType.Checkmark
        }
        
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if(indexPath.row == self.arrItems.count){
            let controller : FJAddMoreFruitViewController = FJAddMoreFruitViewController(nibName: "FJAddMoreFruitViewController", bundle: nil)
            self.navigationController?.pushViewController(controller, animated: true)
        }else{
            var selectedFruit: FruitModel = self.arrItems[indexPath.row]
            var isExist: Bool = false
            for fruit in self.arrSelectedItems{
                if(fruit.fruitName == selectedFruit.fruitName){
                    isExist = true
                    self.arrSelectedItems.removeAtIndex(indexPath.row)
                    break;
                }else{
                    isExist = false
                }
            }
            if(!isExist){
                self.arrSelectedItems.append(selectedFruit)
            }
        }
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}
