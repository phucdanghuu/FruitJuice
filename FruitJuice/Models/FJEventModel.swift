//
//  FJEventModel.swift
//  FruitJuice
//
//  Created by Tran Kien on 10/22/14.
//  Copyright (c) 2014 Phuc Dang. All rights reserved.
//

import Foundation
class FJEventModel: NSObject {
    var name:String
    var closeTime:NSDate!
    var id:String!
    var foodDetails:Array<FruitModel>!
    
    override init() {
        name = ""
    
    }
    
    func toDic()->NSDictionary {
        var dic:NSMutableDictionary = NSMutableDictionary()
        
        if (self.id != nil) {
            dic.setObject(self.id, forKey: "id")
        }
        
        dic.setObject(name, forKey: "name")
        dic.setObject(self.closeTime.timeIntervalSince1970, forKey: "close_time")
        
        if (self.foodDetails != nil && foodDetails.count > 0) {
           var  arrFoodDtails:Array<NSDictionary> = Array<NSDictionary>()
            
            var len:Int = self.foodDetails.count
           
            for (var i = 0; i < len; i++) {
                arrFoodDtails.append(self.foodDetails[i].toDic())
            }
            
            
            dic.setObject(arrFoodDtails, forKey: "food_details")
        }
        
        return dic
    }
}