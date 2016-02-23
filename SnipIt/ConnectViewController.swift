////
////  ConnectViewController.swift
////  SnipIt
////
////  Created by Nikhil Nandkumar on 2/20/16.
////  Copyright © 2016 divnik. All rights reserved.
////
//
//import UIKit
//import SafariServices
//
///*
//SPTArtist
//SPTAudioStreamingMetadataArtistName
//SPTAudioStreamingMetadataTrackName
//SPTAudioStreamingMetadataTrackURI
//SPTSearch
//SPTSearchQueryType
//SPTTrack
//SPTTrackProvider
//*/
//
//class ConnectViewController: UIViewController, SFSafariViewControllerDelegate {
//
//    var session: SPTSession?
//    var player: SPTAudioStreamingController?
//    
//    
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    
//    @IBAction func spotifyButtonPressed (sender: UIButton!) {
//        
//        
//        SPTAuth.defaultInstance().clientID="aaf761970ba2495e8c8c754de6f727f2"
//        SPTAuth.defaultInstance().redirectURL=NSURL(string: "snipit-app-login://callback")
//        SPTAuth.defaultInstance().requestedScopes=[SPTAuthStreamingScope]
//        
//        let loginurl=SPTAuth.defaultInstance().loginURL
//        
//        let svc = SFSafariViewController(URL: loginurl!)
//        svc.delegate = self
//        self.presentViewController(svc, animated: true, completion: nil)
//        
//        
//
//        
//        //self.performSegueWithIdentifier("finalHome", sender: nil)
//    }
//    
//    func safariViewControllerDidFinish(controller: SFSafariViewController)
//    {
//        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(1 * Double(NSEC_PER_SEC)))
//        dispatch_after(delayTime, dispatch_get_main_queue()) {
//            self.performSegueWithIdentifier("finalHome", sender: nil)
//        }
////        let loginurl=SPTAuth.defaultInstance().loginURL
////        
//    
////        if SPTAuth.defaultInstance().canHandleURL(loginurl){
////            
////            SPTAuth.defaultInstance().handleAuthCallbackWithTriggeredAuthURL(loginurl, callback: { (error, session) -> Void in
////                if error != nil{
////                    NSLog("*** AUTH ERROR: %@", error)
////                    return
////                }
////                self.playUsingSession(session)
////            })
////        }
////
//    }
//    
////    func playUsingSession(session:SPTSession){
////        if self.player == nil{
////            self.player=SPTAudioStreamingController(clientId: SPTAuth.defaultInstance().clientID)
////        }
////        self.player?.loginWithSession(session, callback: { (error) -> Void in
////            if error != nil{
////                NSLog("***Logging in got error: %@", error)
////                return
////            }
////            ///playing part with the url
////            let trackURI=NSURL(string: "spotify:track:58s6EuEYJdlb0kO7awm3Vp")
////            self.player?.playURIs([trackURI!], fromIndex: 0, callback: { (error) -> Void in
////                if error != nil{
////                    NSLog("***Starting playback got error: %@",error)
////                    return
////                }
////            })
////        })
////    }
//
//    
//    //spotify done
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//}
