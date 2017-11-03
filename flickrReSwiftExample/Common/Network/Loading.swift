//
//  Loading.swift
//  flickrReSwiftExample
//
//  Created by Sai Teja Jammalamadaka on 11/4/17.
//  Copyright © 2017 tsjamm. All rights reserved.
//

enum Loading<T> {
    case notAsked
    case loading
    case loaded(T)
    case error(Error)
}
