//
//  post.swift
//  SnipIt
//
//  Created by Nikhil Nandkumar on 2/20/16.
//  Copyright © 2016 divnik. All rights reserved.
//

import Foundation

class Post {
    private var _userName: String!
    private var _songName: String!
    private var _artistName: String!
    private var _postKey: String!
    
    var userName: String {
        return _userName
    }
    
    var songName: String {
        return _songName
    }
    
    var artistName: String {
        return _artistName
    }
    
    var postKey: String {
        return _postKey
    }
    
    init(song: String!, artist: String!) {
        self._songName = song
        self._artistName = artist
    }
    
    init(postKey: String, dictionary: Dictionary<String, AnyObject>) {
        if let songTitle = dictionary["name"] as? String {
            self._songName = songTitle
        }
        if let artist = dictionary["artist"] as? String {
            self._artistName = artist
        }

    }
    
    
}