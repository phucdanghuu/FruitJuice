//
//  FruitModel.swift
//  FruitJuice
//
//  Created by Phuc Dang on 10/21/14.
//  Copyright (c) 2014 Phuc Dang. All rights reserved.
//

import Foundation
class FruitModel {
    var fruitName : String
    var fruitQuantity : Int
    var isOrdered : Bool
    
    init(name : String, isOrdered: Bool, quantity: Int){
        self.fruitName = name
        self.isOrdered = isOrdered
        self.fruitQuantity = quantity
    }
}