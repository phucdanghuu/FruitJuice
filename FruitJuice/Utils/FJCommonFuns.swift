//
//  FJCommonFuns.swift
//  FruitJuice
//
//  Created by Tran Kien on 10/22/14.
//  Copyright (c) 2014 Phuc Dang. All rights reserved.
//

import Foundation
class FJCommonFuns: NSObject {
    class func getJSON(urlToRequest: String) -> NSData{
        return NSData(contentsOfURL: NSURL(string: urlToRequest)!)!
    }
    
    class func parseJSON(inputData: NSData) -> NSDictionary{
        var error: NSError?
        var boardsDictionary: NSDictionary = NSJSONSerialization.JSONObjectWithData(inputData, options: NSJSONReadingOptions.MutableContainers, error: &error) as NSDictionary
        return boardsDictionary
    }
    
    class func parseErrorDicToNSError(boardsDictionary:NSDictionary) ->NSError! {
        if boardsDictionary["error"] == nil {
            
            return nil;
        } else {
            
            var errorDic: NSDictionary =  boardsDictionary.objectForKey("error") as NSDictionary
            println(errorDic)
            
            var message: NSString = errorDic.objectForKey("message") as NSString
            var code: Int = errorDic.objectForKey("code") as Int
            
            var error:NSError = NSError(domain: "login", code: code, userInfo: [NSLocalizedDescriptionKey: message])
            
            return error
        }

    }
    
    class func isErrorDic(dic: NSDictionary) ->Bool {
        return dic["error"] != nil
    }
}