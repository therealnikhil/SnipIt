//
//  DataService.swift
//  SnipIt
//
//  Created by Nikhil Nandkumar on 2/20/16.
//  Copyright © 2016 divnik. All rights reserved.
//

import Foundation
import Firebase

class DataService {
    static let ds = DataService()
    
    private var _REF_BASE = Firebase(url: "https://snipitapp.firebaseio.com/")
    private var _REF_POSTS = Firebase(url: "https://snipitapp.firebaseio.com/posts")
    private var _REF_USERS = Firebase(url: "https://snipitapp.firebaseio.com/users")
    private var _REF_JAMQ = Firebase(url: "https://snipitapp.firebaseio.com/jamq")
    
    var REF_BASE: Firebase {
        return _REF_BASE
    }
    
    var REF_POSTS: Firebase {
        return _REF_POSTS
    }
    
    var REF_USERS: Firebase {
        return _REF_USERS
    }
    
    var REF_JAMQ: Firebase {
        return _REF_JAMQ
    }
    
    var REF_USER_CURRENT: Firebase {
        let uid = NSUserDefaults.standardUserDefaults().valueForKey("UID") as! String
        let user = Firebase(url: "https://snipitapp.firebaseio.com/").childByAppendingPath("users").childByAppendingPath(uid)
        
        return user!
    }
    
    func createUser(uid: String, user: Dictionary<String, String>) {
        REF_USERS.childByAppendingPath(uid).setValue(user)
    }
}