//
//  Result.swift
//  flickrReSwiftExample
//
//  Created by Sai Teja Jammalamadaka on 11/4/17.
//  Copyright © 2017 tsjamm. All rights reserved.
//

enum Result<T> {
    case success(T)
    case failure(Error)
}
