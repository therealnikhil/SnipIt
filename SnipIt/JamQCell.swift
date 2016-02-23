//
//  JamQCell.swift
//  SnipIt
//
//  Created by Nikhil Nandkumar on 2/21/16.
//  Copyright © 2016 divnik. All rights reserved.
//

import UIKit

class JamQCell: UITableViewCell {

    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    
    var post: Post!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(post: Post) {
        self.post = post
        
        self.songNameLabel.text = post.songName
        self.artistLabel.text = post.artistName
    }

}
