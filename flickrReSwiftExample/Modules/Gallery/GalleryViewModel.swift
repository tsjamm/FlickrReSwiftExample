//
//  GalleryViewModel.swift
//  flickrReSwiftExample
//
//  Created by Sai Teja Jammalamadaka on 11/4/17.
//  Copyright © 2017 tsjamm. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

struct GalleryViewModel: GalleryViewDataSource {
    
    private let numberOfSections = 1
    
    private var numberOfCells: Int!
    private var flickrResponse: FlickrResponse!
    
//    init(flickrResponse: FlickrResponse) {
//        self.flickrResponse = flickrResponse
//        self.numberOfCells = flickrResponse.photo.count
//    }
    
    init(loadingFlickrResponse: Loading<FlickrResponse>) {
        switch loadingFlickrResponse {
        case .loaded(let fResponse):
            self.flickrResponse = fResponse
            self.numberOfCells = fResponse.photo.count
        default:
            ()
        }
    }
    
    func getNumberOfSections() -> Int {
        return self.numberOfSections
    }
    
    func getNumberOfCellsForSection(section: Int) -> Int {
        return numberOfCells
    }
    
    func configureCellAtIndexPath(collectionView: UICollectionView, cell: GalleryPhotoCell, indexPath: NSIndexPath) {
        cell.backgroundColor = UIColor.white
        let row = indexPath.row
        if row < self.numberOfCells {
            var fPhoto = self.flickrResponse.photo[row]
            if let fThumb = fPhoto.thumbnail {
                cell.imageView.image = fThumb
                /// not downloading thumb if cached response without thumb (not worth it because it might change)
            } else if !self.flickrResponse.isCached,
                let thumbURL = fPhoto.getMediumURL() {
                cell.imageView.af_setImage(withURL: thumbURL as URL,
                                           imageTransition: UIImageView.ImageTransition.crossDissolve(0.2),
                                                  runImageTransitionIfCached: true,
                                                  completion: { (alamofireResponse) in
                                                    fPhoto.thumbnail = alamofireResponse.result.value
                })
            }
        }
    }
    
    func configureSectionHeaderAtIndexPath(collectionView: UICollectionView, sectionHeader: GallerySectionHeaderView, indexPath: NSIndexPath) {
        sectionHeader.headerLabel.text = self.flickrResponse.searchTerm
        sectionHeader.isLoading = self.flickrResponse.isCached
    }
    
}
