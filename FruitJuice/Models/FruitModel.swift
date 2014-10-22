//
//  FruitModel.swift
//  FruitJuice
//
//  Created by Phuc Dang on 10/21/14.
//  Copyright (c) 2014 Phuc Dang. All rights reserved.
//

import Foundation
class FruitModel {
    var name : String
    var isOrdered : Bool
    
    init(name : String, isOrdered: Bool){
        self.name = name
        self.isOrdered = isOrdered
    }
}