//
//  FlickrAPIService.swift
//  flickrReSwiftExample
//
//  Created by Sai Teja Jammalamadaka on 11/4/17.
//  Copyright © 2017 tsjamm. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class FlickrAPIService {
    
    static func fetchFlickrDataFromNetwork(searchTerm:String, callback:@escaping (FlickrResponse)->()) {
        guard let flickrURLString = flickrSearchURL(searchTerm: searchTerm)?.absoluteString else {
            NSLog("Error: Flickr URL not correct.")
            return
        }
        
        getJSONResult(url: flickrURLString) { (response) in
            if let fResponse = processFlickrResponseObject(responseObject: response.result.value as AnyObject, searchTerm: searchTerm) {
                callback(fResponse)
            }
        }
    }
    
    private static func getJSONResult(url:String, queryParams:[String:String]?=nil, callback:@escaping ((_ response: DataResponse<Any>)->())) {
        Alamofire.request(url, method: .get, parameters: queryParams)
            .responseJSON { response in
                if response.data != nil {
                    callback(response)
                }
        }
    }
    
    private static func flickrSearchURL(searchTerm:String, page:Int = 1, perPage:Int = 20) -> NSURL? {
        
        guard let escapedTerm = searchTerm.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) else {
            NSLog("Error: Search Term Not Able to Escape")
            return nil
        }
        let URLString = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(Constants.flickrAPIKey)&text=\(escapedTerm)&per_page=\(perPage)&format=json&nojsoncallback=1&page=\(page)"
        return NSURL(string: URLString)
    }
    
    private static func processFlickrResponseObject(responseObject:AnyObject?, searchTerm: String) -> FlickrResponse? {
        
        guard let responseMap = responseObject as? [String:AnyObject] else {
            NSLog("Error: Flicker Response Object is not a map...")
            return nil
        }
        guard let photosMap = responseMap["photos"] as? [String:AnyObject] else {
            NSLog("Error: Flicker Response Data does not have photos map")
            return nil
        }
        
        var fResponse = FlickrResponse(dataMap: photosMap)
        fResponse.searchTerm = searchTerm
        fResponse.isCached = false
        return fResponse
        
    }
}
