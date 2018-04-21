//
//  PhotoDetailAssembly.swift
//  ViperFlick
//
//  Created by Rumah Ulya on 10/04/18.
//  Copyright © 2018 Rumah Ulya. All rights reserved.
//

import UIKit

class PhotoDetailAssembly {
    
    static let sharedInstance = PhotoDetailAssembly()
    
    func configure(_ viewController: PhotoDetailViewController) {
        let APIDataManager: FlickrPhotoLoadImageProtocol = FlickrDataManager()
        let interactor = PhotoDetailInteractor()
        let presenter  = PhotoDetailPresenter()
        viewController.presenter = presenter
        presenter.view = viewController
        interactor.presenter = presenter
        presenter.interactor = interactor
        
        interactor.imageDataManager = APIDataManager
    }
    
}
