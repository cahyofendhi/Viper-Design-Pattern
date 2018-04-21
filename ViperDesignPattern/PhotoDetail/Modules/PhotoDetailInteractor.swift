//
//  PhotoDetailInteractor.swift
//  ViperFlick
//
//  Created by Rumah Ulya on 10/04/18.
//  Copyright © 2018 Rumah Ulya. All rights reserved.
//

import UIKit

protocol PhotoDetailInteractorOutput: class {
    func sendLoadedPhotoImage(_ url: URL)
}

protocol PhotoDetailInteractorInput: class {
    func configurePhotoModel(_ photoModel: FlickrPhotoModel)
    func loadImageFromUrl()
    func getPhotoImageTitle() -> String
}

class PhotoDetailInteractor: PhotoDetailInteractorInput {
    
    weak var presenter: PhotoDetailInteractorOutput!
    var photoModel: FlickrPhotoModel?
    var imageDataManager: FlickrPhotoLoadImageProtocol!
    
    func configurePhotoModel(_ photoModel: FlickrPhotoModel) {
        self.photoModel = photoModel
    }
    
    func loadImageFromUrl() {
        print("image URl \(self.photoModel?.largePhotoUrl)")
        self.presenter.sendLoadedPhotoImage(self.photoModel?.largePhotoUrl as! URL)
//        imageDataManager.loadImageFromUrl((self.photoModel?.largePhotoUrl)!) { (image, error) in
//            if let image = image {
//                self.presenter.sendLoadedPhotoImage(image)
//            }
//        }
    }
    
    func getPhotoImageTitle() -> String {
        if let title = self.photoModel?.title {
            return title
        }
        return ""
    }
    
    
}
