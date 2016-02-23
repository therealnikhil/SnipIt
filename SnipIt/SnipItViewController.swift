//
//  SnipItViewController.swift
//  SnipIt
//
//  Created by Nikhil Nandkumar on 2/19/16.
//  Copyright © 2016 divnik. All rights reserved.
//

import UIKit
import MediaPlayer

class SnipItViewController: UIViewController {
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Snip It"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // snipItButton.layer.cornerRadius = 0.5 * snipItButton.bounds.size.width
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func snipItButton(sender: AnyObject) {
        
        let player = MPMusicPlayerController.systemMusicPlayer()
        let mediaItem = player.nowPlayingItem
        if mediaItem != nil { // Check if there was actually something playing
            let title: String = mediaItem!.valueForProperty(MPMediaItemPropertyTitle) as! String
            let albumTitle: String = mediaItem!.valueForProperty(MPMediaItemPropertyAlbumTitle) as! String
            let artist: String = mediaItem!.valueForProperty(MPMediaItemPropertyArtist) as! String
            postToFirebase(title, artist: artist)
        }
        
    }
    
    func postToFirebase(songtitle: String!, artist: String!) {
        var post: Dictionary<String,AnyObject> = [
            "name": songtitle,
            "artist": artist
        ]
        
        let firebasePost = DataService.ds.REF_POSTS.childByAutoId()
        firebasePost.setValue(post)
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
