//
//  AppActions.swift
//  flickrReSwiftExample
//
//  Created by Sai Teja Jammalamadaka on 11/4/17.
//  Copyright © 2017 tsjamm. All rights reserved.
//

import ReSwift

struct IncreaseAction: Action {}
struct DecreaseAction: Action {}
struct ResetAction: Action {}

enum AppAction: Action {
    case search(String?)
    case handleLoadResult(Result<FlickrResponse>)
}
