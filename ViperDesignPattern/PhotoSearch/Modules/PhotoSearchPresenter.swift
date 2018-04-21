//
//  PhotoSearchPresenter.swift
//  ViperFlick
//
//  Created by Rumah Ulya on 10/04/18.
//  Copyright © 2018 Rumah Ulya. All rights reserved.
//

import UIKit

protocol PhotoSearchPresenterInput: PhotoViewControllerOutput, PhotoSearchInteractorOutput {
    
}

class PhotoSearchPresenter: PhotoSearchPresenterInput {
    
    var view: PhotoViewControllerInput!
    var interactor: PhotoSearchInteractorInput!
    var router: PhotoSearchRouterInput!
    
    func fetchphotos(_ searchtag: String, page: NSInteger) {
        if view.getTotalPhoneCount() == 0 {
            view.showWaitingView()
        }
        interactor.fetchAllPhotosFromDataManager(searchtag, page: page)
    }
    
    // service return photos and interactor passes all data
    func providedPhotos(_ photos: [FlickrPhotoModel], totalPages: NSInteger) {
        self.view.hideWaitingView()
        self.view.displayFetchedPhotos(photos, totalpages: totalPages)
    }
    
    // show error message
    func serviceError(_ error: NSError) {
        self.view.displayErrorView(defaultErrorMessage)
    }
    
    func gotoPhotoDetailScreen() {
        self.router.navigateToPhotoDetail()
    }
    
    func pastDataToNextScene(_ segue: UIStoryboardSegue) {
        self.router.passDataToNextScene(segue)
    }
    
}
