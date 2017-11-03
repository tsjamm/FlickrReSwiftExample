//
//  GalleryViewController.swift
//  flickrReSwiftExample
//
//  Created by Sai Teja Jammalamadaka on 11/4/17.
//  Copyright © 2017 tsjamm. All rights reserved.
//

import UIKit
import ReSwift

/// The Gallery View Controller presents a collection view of the images searched for by the search field.
class GalleryViewController: UIViewController {
    
    @IBOutlet var galleryView: GalleryView! {
        didSet {
            self.galleryView.delegate = self
        }
    }
    @IBOutlet weak var searchField: UITextField! {
        didSet {
            searchField.delegate = self
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ReSwiftManager.getStore().subscribe(self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        ReSwiftManager.getStore().unsubscribe(self)
    }
    
    func doSearchFor(text: String) {
        guard text != "" else {
            return
        }
        searchField.resignFirstResponder()
        searchField.text = ""
        
        ReSwiftManager.getStore().dispatch(AppAction.search(text))
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        galleryView.invalidateLayout()
        //NSLog("GalleryVC: view will layout subviews")
    }
    
    @IBAction func onSearchTap(sender: AnyObject) {
        if let _searchedText = searchField.text {
            doSearchFor(text: _searchedText)
        }
    }
    
}

/// This is for when the searchbar is handled (It is present in Navigation Item, hence not in Gallery View)
extension GalleryViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let _searchedText = textField.text {
            doSearchFor(text: _searchedText)
        }
        return true
    }
}

/// This is for when the user does something in the GalleryView
extension GalleryViewController: GalleryViewDelegate {
    
    func didTapOnCellAtIndexPath(collectionView: UICollectionView, indexPath: NSIndexPath) {
        // the storyboard segue is currently showing the photo view controller.
        self.searchField.resignFirstResponder()
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        self.searchField.resignFirstResponder()
    }
}

extension GalleryViewController: StoreSubscriber {
    func newState(state: AppState) {
        if case Loading.loaded = state.photos {
            self.galleryView.dataSource = GalleryViewModel(loadingFlickrResponse: state.photos)
        }
    }
}
