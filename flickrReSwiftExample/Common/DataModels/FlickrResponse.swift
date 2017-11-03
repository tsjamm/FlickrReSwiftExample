//
//  FlickrResponse.swift
//  flickrReSwiftExample
//
//  Created by Sai Teja Jammalamadaka on 11/4/17.
//  Copyright © 2017 tsjamm. All rights reserved.
//

import UIKit

struct FlickrResponse {
    
    static let KEY_PAGE = "page"
    static let KEY_PAGES = "pages"
    static let KEY_PER_PAGE = "perpage"
    static let KEY_TOTAL = "total"
    static let KEY_PHOTO = "photo"
    
    let page:Int?
    let pages:Int?
    let perPage:Int?
    let total:Int?
    
    var photo = [FlickrPhoto]()
    
    var searchTerm:String = ""
    var isCached:Bool = false
    
    var timestamp:TimeInterval!
    
    init(dataMap: [String:AnyObject]) {
        self.timestamp = NSDate().timeIntervalSince1970
        
        self.page = dataMap["page"] as? Int
        self.pages = dataMap["pages"] as? Int
        self.perPage = dataMap["perpage"] as? Int
        self.total = dataMap["total"] as? Int
        
        if let photoList = dataMap["photo"] as? [[String:AnyObject]] {
            for photoMap in photoList {
                self.photo.append(FlickrPhoto(dataMap: photoMap))
            }
        }
    }
}
