//
//  FJApiClient.swift
//  FruitJuice
//
//  Created by Tran Kien on 10/22/14.
//  Copyright (c) 2014 Phuc Dang. All rights reserved.
//

import UIKit

class FJApiClient: NSObject {
    
        var baseUrl:String
    var session_id : String!
    var isAdmin: Bool
    
    class func sharedApiClient() -> FJApiClient {
        
        struct Static {
            static let instance : FJApiClient = FJApiClient()
        }
        
        return Static.instance
        
    }
    
    override init() {
        self.baseUrl = FJConstants.BASE_URL
        self.isAdmin = false
        
        if (NSUserDefaults.standardUserDefaults().boolForKey("is_admin") == true) {
            self.isAdmin = true
        }
        self.session_id = NSUserDefaults.standardUserDefaults().objectForKey("session_id") as String
    }
    
    func setSessionID(sessionId:String) {
        self.session_id = sessionId
        
        NSUserDefaults.standardUserDefaults().setObject(sessionId, forKey: "session_id")
        NSUserDefaults.standardUserDefaults().synchronize()
    
    }
    
    func setIsAdmin(isAdmin:Bool) {
        self.isAdmin = isAdmin
        
        NSUserDefaults.standardUserDefaults().setBool(isAdmin, forKey: "is_admin")
        NSUserDefaults.standardUserDefaults().synchronize()
        
    }
    
    func postRequest(
        relativeUrl:String,
        parameters: NSDictionary,
        comletionBlock:(operation: AFHTTPRequestOperation!,responseObj: AnyObject! ) -> Void,
        failureBlock :(operation:AFHTTPRequestOperation!, error:NSError!) -> Void) {

            var urlString = self.baseUrl.stringByAppendingPathComponent(relativeUrl)
            
            var url = NSURL(string: urlString)
            
            var request = NSURLRequest(URL: url!)
            
            
            var jsonRequest = AFJSONRequestSerializer()
            
            var error:NSErrorPointer = nil
            
            var mutableRequest: NSMutableURLRequest = jsonRequest.requestWithMethod("POST", URLString: urlString, parameters: parameters, error: error)
          
          
            
            
            
        var operater: AFHTTPRequestOperation = AFHTTPRequestOperation(request: mutableRequest)

            if (self.session_id != nil && !self.session_id.isEmpty) {
                mutableRequest.addValue(self.session_id, forHTTPHeaderField: "session_id")
            }
            
        //    operater.responseSerializer = AFJSONResponseSerializer(readingOptions: 1)
            
        operater.setCompletionBlockWithSuccess(comletionBlock, failureBlock)
        
        operater.start()
    }
    
    func login(username:String, password:String, responseBlock: (isSuc:Bool, error:NSError!) -> Void) {
        
        var par = Dictionary(dictionaryLiteral: ("username", username), ("password", password))
        
        FJApiClient.sharedApiClient().postRequest("login", parameters: par, comletionBlock: { (operation, responseObj) -> Void in
            var boardsDictionary: NSDictionary = FJCommonFuns.parseJSON(responseObj as NSData)
            
            if !FJCommonFuns.isErrorDic(boardsDictionary) {
                var session_id = boardsDictionary.objectForKey("session_id") as NSString
                var isAdmin = boardsDictionary.objectForKey("is_admin") as Bool
                
                self.session_id = session_id;
                self.isAdmin = isAdmin
                
                responseBlock(isSuc: true, error: nil)
            } else {
               
               var error:NSError = FJCommonFuns.parseErrorDicToNSError(boardsDictionary)
                
                if error.code == 401 {
                    self .clearSession()
                    
                    NSNotificationCenter.defaultCenter().postNotificationName(FJConstants.SESSION_EXPIRED, object: error)
                } else {
                
                    responseBlock(isSuc: false, error: error)
                }
            }
            
            
            }) { (operation, error) -> Void in
                println(error)
        }
    }
    
    func createEvent(event:FJEventModel, responseBlock:(isSuc:Bool, eventModel:FJEventModel!, error:NSError!) -> Void) {
        var par = ["event" : event.toDic()]
        
        FJApiClient.sharedApiClient().postRequest("createevent", parameters: par, comletionBlock: { (operation, responseObj) -> Void in
            var boardsDictionary: NSDictionary = FJCommonFuns.parseJSON(responseObj as NSData)
            
            if !FJCommonFuns.isErrorDic(boardsDictionary) {
                
                responseBlock(isSuc: true, eventModel: nil, error:nil)
                
            } else {
                
                var error:NSError = FJCommonFuns.parseErrorDicToNSError(boardsDictionary)
                
                if error.code == 401 {
                    self .clearSession()
                    
                    NSNotificationCenter.defaultCenter().postNotificationName(FJConstants.SESSION_EXPIRED, object: error)
                } else {
                    
                    responseBlock(isSuc: false, eventModel: nil, error:error)
                }
            }
            
            
            }) { (operation, error) -> Void in
                println(error)
        }

    }
    
    
    func clearSession() {
        NSUserDefaults.standardUserDefaults().setObject(nil, forKey: "session_id")
        NSUserDefaults.standardUserDefaults().setBool(false, forKey: "is_admin")
        NSUserDefaults.standardUserDefaults().synchronize()

    }
}
