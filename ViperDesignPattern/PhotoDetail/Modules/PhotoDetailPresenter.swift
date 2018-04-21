//
//  PhotoDetailPresenter.swift
//  ViperFlick
//
//  Created by Rumah Ulya on 10/04/18.
//  Copyright © 2018 Rumah Ulya. All rights reserved.
//

import UIKit

protocol PhotoDetailPresenterInput: PhotoDetailViewControllerOutput, PhotoDetailInteractorOutput {}

class PhotoDetailPresenter: PhotoDetailPresenterInput {
    
    weak var view: PhotoDetailViewControllerInput!
    var interactor: PhotoDetailInteractorInput!
    
    // passing data from PhotoSearch Module Router
    func saveSelectedPhotoModel(_ photoModel: FlickrPhotoModel) {
        self.interactor.configurePhotoModel(photoModel)
    }
    
    func loadLargePhotoImage() {
        self.interactor.loadImageFromUrl()
    }
    
    // result comes from interactor
    func sendLoadedPhotoImage(_ url: URL) {
        self.view.addLargeLoadedPhoto(url)
    }
    
    func getPhotoImageTitle() {
        let imageTitle = self.interactor.getPhotoImageTitle()
        self.view.addPhotoImageTitle(imageTitle)
    }
    
}
