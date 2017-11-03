//
//  AppReducer.swift
//  flickrReSwiftExample
//
//  Created by Sai Teja Jammalamadaka on 11/4/17.
//  Copyright © 2017 tsjamm. All rights reserved.
//

import ReSwift

struct AppReducer: Reducer {
    
    func handleAction(action: Action, state: AppState?) -> AppState {
        var state = state ?? AppState()
        
        switch action as? AppAction {
        case nil:
            break
            
        case .search(let topic)?:
            state.topic = topic
            state.photos = .loading
            if let _topic = topic {
                FlickrAPIService.fetchFlickrDataFromNetwork(searchTerm: _topic, callback: { (fResponse) in
                    ReSwiftManager.getStore().dispatch(AppAction.handleLoadResult(Result.success(fResponse)))
                })
            }
            
        case .handleLoadResult(let result)?:
            switch result {
            case .failure(let error):
                state.photos = .error(error)
                
            case .success(let flickrResult):
                state.photos = .loaded(flickrResult)
            }
            
        }
        
        return state
    }
    
}
