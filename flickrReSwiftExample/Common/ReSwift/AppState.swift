//
//  AppState.swift
//  flickrReSwiftExample
//
//  Created by Sai Teja Jammalamadaka on 11/4/17.
//  Copyright © 2017 tsjamm. All rights reserved.
//

import ReSwift

struct AppState: StateType {
    var topic: String? = nil
    var photos: Loading<FlickrResponse> = .notAsked
}
