//
//  FJAddMoreFruitViewController.swift
//  FruitJuice
//
//  Created by Phuc Dang on 10/22/14.
//  Copyright (c) 2014 Phuc Dang. All rights reserved.
//

import UIKit

typealias CompletionBlock = FruitModel -> ()

class FJAddMoreFruitViewController: UIViewController {

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
    }
    
    @IBOutlet weak var quantitySlider: UISlider!
    @IBOutlet weak var nameFruitTxt: UITextField!
    
    var block:CompletionBlock!
    
    func setBlock(block:CompletionBlock) {
        self.block = block
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func okPressed(sender: AnyObject) {
        var fruit:FruitModel = FruitModel()
        fruit.fruitName = nameFruitTxt.text
        fruit.isOrdered = false
        fruit.fruitQuantity = Int( self.quantitySlider.value)
        
        if (self.block != nil) {
            self.block(fruit)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
