//
//  AppDelegate.swift
//  SnipIt
//
//  Created by Nikhil Nandkumar on 2/19/16.
//  Copyright © 2016 divnik. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
///////spotify
    var session: SPTSession?
    var player: SPTAudioStreamingController?
    
//// end spotify
    
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {/*
        SPTAuth.defaultInstance().clientID="aaf761970ba2495e8c8c754de6f727f2"
        SPTAuth.defaultInstance().redirectURL=NSURL(string: "snipit-app-login://callback")
        SPTAuth.defaultInstance().requestedScopes=[SPTAuthStreamingScope]
        
        //Construct a login URL
        
        let loginurl=SPTAuth.defaultInstance().loginURL
        application.performSelector("openURL:", withObject: loginurl, afterDelay: 0.1)
        */
        
        // Override point for customization after application launch.
        return FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        FBSDKAppEvents.activateApp()
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func application(application:UIApplication,openURL url:NSURL, sourceApplication: String?,annotation: AnyObject)-> Bool{
        if (FBSDKApplicationDelegate.sharedInstance().application(application, openURL: url, sourceApplication: sourceApplication, annotation: annotation)) {
        let vc = UIApplication.sharedApplication().keyWindow?.rootViewController as? ViewController
        vc?.performSegueWithIdentifier("homePage", sender: nil)
        return true
        } else {
        if SPTAuth.defaultInstance().canHandleURL(url){
        SPTAuth.defaultInstance().handleAuthCallbackWithTriggeredAuthURL(url, callback: { (error, session) -> Void in
        if error != nil{
        NSLog("*** AUTH ERROR: %@", error)
        return
        }
        let tab = UIApplication.sharedApplication().keyWindow?.rootViewController!.presentedViewController as? UITabBarController
        let jamq = (tab?.selectedViewController as? UINavigationController)?.visibleViewController as? JamQViewController
        jamq?.playUsingSession(session)
        })
        return true
        }
        }
        return false
    }
}

