//
//  PhotoSearchInteractor.swift
//  ViperFlick
//
//  Created by Rumah Ulya on 10/04/18.
//  Copyright © 2018 Rumah Ulya. All rights reserved.
//

import UIKit

protocol PhotoSearchInteractorInput: class {
     func fetchAllPhotosFromDataManager(_ searchTag: String, page: NSInteger)
}

protocol PhotoSearchInteractorOutput: class {
    func providedPhotos(_ photos: [FlickrPhotoModel], totalPages: NSInteger)
    func serviceError(_ error: NSError)
}

class PhotoSearchInteractor : PhotoSearchInteractorInput {
    
    weak var presenter: PhotoSearchInteractorOutput!
    var APIDataManager: FlickrSearchPhotoProtocol!
    
    func fetchAllPhotosFromDataManager(_ searchTag: String, page: NSInteger) {
        APIDataManager.fetchPhotosForSearchText(searchText: searchTag, page: page) { (error, totalPages, flickrPhotos) in
            if let photos = flickrPhotos {
                self.presenter.providedPhotos(photos, totalPages: totalPages)
                print("Data \(String(describing: flickrPhotos))")
            } else if let error = error {
                print(error)
                self.presenter.serviceError(error)
            }
        }
    }
    
}
