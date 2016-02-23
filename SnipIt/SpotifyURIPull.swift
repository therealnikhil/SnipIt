//
//  SpotifyURIPull.swift
//  SnipIt
//
//  Created by New Macbook on 2/21/16.
//  Copyright © 2016 divnik. All rights reserved.
//

import Foundation

var GLOBALURI: NSURL?
var songnametobeuried: String? = "without you hinder"

func songnamerefresh(newsongname: String) -> Void {
    songnametobeuried=newsongname
}

func getPlayableUriForFirstPartialTrackInListPage(listPage: SPTListPage?) -> NSURL? {
    
    if let items = listPage?.items {
        
        if let firstPartialTrack = items.first as? SPTPartialTrack {
            
            return firstPartialTrack.playableUri
            
        }
        
    }
    
    return nil
    
}

func fetchListPageForQuery(query: String, withCompletionHandler handler: (SPTListPage?) -> Void) {
    
    SPTSearch.performSearchWithQuery(query, queryType: .QueryTypeTrack, accessToken: SPTAuth.defaultInstance().session.accessToken) { (error,listPage) -> Void in
        
        //replace searchText with staticText, and to get the searchback put searchText
        
        handler(listPage as? SPTListPage)
        
        return
        
    }
    
}