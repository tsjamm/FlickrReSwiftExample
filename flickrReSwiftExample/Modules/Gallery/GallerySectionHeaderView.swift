//
//  GallerySectionHeaderView.swift
//  flickrReSwiftExample
//
//  Created by Sai Teja Jammalamadaka on 11/4/17.
//  Copyright © 2017 tsjamm. All rights reserved.
//

import UIKit

/// The header section for the collection view
class GallerySectionHeaderView: UICollectionReusableView {
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    //@IBOutlet weak var searchField: UISearchBar!
    
    var isLoading:Bool = false
}

