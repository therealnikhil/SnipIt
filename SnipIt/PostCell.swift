//
//  PostCell.swift
//  SnipIt
//
//  Created by Nikhil Nandkumar on 2/20/16.
//  Copyright © 2016 divnik. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {
    
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var addToQueue: UIImageView!
    
    var post: Post!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let tap = UITapGestureRecognizer(target: self, action: "likeTapped:")
        tap.numberOfTapsRequired = 1
        
        addToQueue.addGestureRecognizer(tap)
        addToQueue.userInteractionEnabled = true
    }

    func configureCell(post: Post) {
        self.post = post
        
        self.songNameLabel.text = post.songName
        self.artistLabel.text = post.artistName
    }
    
    func likeTapped(sender: UITapGestureRecognizer) {
        var post: Dictionary<String,AnyObject> = [
            "name": songNameLabel.text!,
            "artist": artistLabel.text!
        ]
        
        let firebasePost = DataService.ds.REF_JAMQ.childByAutoId()
        firebasePost.setValue(post)
    }

}
