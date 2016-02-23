//
//  JamQViewController.swift
//  SnipIt
//
//  Created by Nikhil Nandkumar on 2/19/16.
//  Copyright © 2016 divnik. All rights reserved.
//

import UIKit
import Firebase

class JamQViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    ///////
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        
        // Do any additional setup after loading the view.
        SPTAuth.defaultInstance().clientID = "aaf761970ba2495e8c8c754de6f727f2"
        SPTAuth.defaultInstance().redirectURL = NSURL(string: "snipit-app-login://callback")
        SPTAuth.defaultInstance().requestedScopes = [SPTAuthStreamingScope]
        
        //Construct a login URL
        
        let loginurl=SPTAuth.defaultInstance().loginURL
        
        UIApplication.sharedApplication().performSelector("openURL:", withObject: loginurl, afterDelay: 0.1)
        
        
        
                // Do any additional setup after loading the view.
                
                tableview.dataSource = self
                tableview.delegate = self
                
                DataService.ds.REF_JAMQ.observeEventType(.Value, withBlock: { snapshot in
                    if let snapshots = snapshot.children.allObjects as? [FDataSnapshot] {
                        self.posts = []
                        for snap in snapshots {
                            if let postDict = snap.value as? Dictionary<String, AnyObject> {
                                let key = snap.key
                                let post = Post(postKey: key, dictionary: postDict)
                                self.posts.append(post)
                            }
                        }
                    }
                    
                    self.tableview.reloadData()
                })
        
        
        
        /*
        fetchListPageForQuery(songnametobeuried!) { (listPage) -> Void in
        
        if let playableUri = getPlayableUriForFirstPartialTrackInListPage(listPage) {
        
        // GLOBALURI = playableUri
        
        self.trackURI = playableUri
        
        }
        
        }
        */
        
    }
    ///////spotify
    
    var session: SPTSession?
    
    var player: SPTAudioStreamingController?
    
    var trackURI: NSURL? // =NSURL(string: GLOBALURI!.absoluteString) // this sets the default track

    
    
    
    
    
    
    
    //////
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "JamQ"
    }
    
    @IBOutlet weak var tableview: UITableView!
    var posts = [Post]()
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Don't delete Refresh, but you can delete the button linked with it
    @IBAction func Refresh(sender: AnyObject) {
        
        fetchListPageForQuery(songnametobeuried!) { (listPage) -> Void in
            
            if let playableUri = getPlayableUriForFirstPartialTrackInListPage(listPage) {
                GLOBALURI = playableUri
                print(GLOBALURI)
            }
            
        }
    }
    
    
    
    
    /// stopping algorigthm
    @IBAction func stop(sender: AnyObject) {
        player?.stop({ (error) -> Void in
            ///
        })
    }
    
    ////set track
    func settrack(newtrackid: String) -> Void{
        let tempsettrack=NSURL(string: newtrackid)
        trackURI = tempsettrack
        
    }
    func namesettrack(newtrackname:String)-> Void{
        songnametobeuried=newtrackname
    }
    
    ///////////
    
    
    @IBAction func FullPlay(sender: AnyObject) {
        //Refresh("Refresh")
        if player == nil{
            player=SPTAudioStreamingController(clientId: SPTAuth.defaultInstance().clientID)
        }
        ///playing part with the url
        //let trackURI=NSURL(string: "spotify:track:58s6EuEYJdlb0kO7awm3Vp")
        //this is what we need to use to play music
        settrack(GLOBALURI!.absoluteString)
        self.player?.playURIs([trackURI!], fromIndex: 0, callback: { (error) -> Void in
            if error != nil{
                NSLog("***Starting playback got error: %@",error)
                return
            }
            //self.performSelector("stop:", withObject: nil, afterDelay: 14)
            
            
        })
        
    }
    /////////////
    @IBAction func playSpotifyMusic(sender: AnyObject) {
        //Refresh("Refresh")
        if player == nil{
            player=SPTAudioStreamingController(clientId: SPTAuth.defaultInstance().clientID)
        }
        ///playing part with the url
        //let trackURI=NSURL(string: "spotify:track:58s6EuEYJdlb0kO7awm3Vp")
        //this is what we need to use to play music
        settrack(GLOBALURI!.absoluteString)   //"spotify:track:0ENSn4fwAbCGeFGVUbXEU3"
        self.player?.playURIs([trackURI!], fromIndex: 0, callback: { (error) -> Void in
            if error != nil{
                NSLog("***Starting playback got error: %@",error)
                return
            }
            self.performSelector("stop:", withObject: nil, afterDelay: 14)
            
            
        })
        
    }
    //*/
    
    
    
    func playUsingSession(session:SPTSession){
        if player == nil{
            player=SPTAudioStreamingController(clientId: SPTAuth.defaultInstance().clientID)
        }
        player?.loginWithSession(session, callback: { (error) -> Void in
            if error != nil{
                NSLog("***Logging in got error: %@", error)
                return
            }
            
            ///playing part with the url
            //let trackURI=NSURL(string: "spotify:track:58s6EuEYJdlb0kO7awm3Vp")
            self.session = session
            //self.player?.playURIs([trackURI!], fromIndex: 0, callback: { (error) -> Void in
            //   if error != nil{
            //     NSLog("***Starting playback got error: %@",error)
            //   return
            // }
            // })
        })
    }
    
    
    //spotify done
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("COUNT_JAMQ = \(posts.count)")
        return posts.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let post = posts[indexPath.row]
        
        if let cell = tableview.dequeueReusableCellWithIdentifier("jamQCell", forIndexPath: indexPath) as? JamQCell {
            cell.configureCell(post)
            return cell
        } else {
            return PostCell()
        }
    }
    
    internal func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let post = posts[indexPath.row]
        
        let searchString = post.songName + " " + post.artistName
        namesettrack(searchString)
        Refresh("Done")
        //print("Search String = \(searchString)")
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
