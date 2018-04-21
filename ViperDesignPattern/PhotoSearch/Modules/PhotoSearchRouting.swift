//
//  PhotoSearchRouting.swift
//  ViperFlick
//
//  Created by Rumah Ulya on 10/04/18.
//  Copyright © 2018 Rumah Ulya. All rights reserved.
//

import UIKit

protocol PhotoSearchRouterInput: class {
    func navigateToPhotoDetail()
    func passDataToNextScene(_ segue: UIStoryboardSegue)
}

class PhotoSearchRouting: PhotoSearchRouterInput {
    
    weak var viewController: PhotoViewController!
    
    func navigateToPhotoDetail() {
        viewController.performSegue(withIdentifier: "ShowPhotoDetail", sender: nil)
    }
    
    func passDataToNextScene(_ segue: UIStoryboardSegue) {
        if segue.identifier == "ShowPhotoDetail" {
            passDatatoShowPhotoDetailScene(segue)
        }
    }
    
    // navigate to another module
    func passDatatoShowPhotoDetailScene(_ segue: UIStoryboardSegue) {
        if let selectedIndexPath = viewController.photoCollectionView.indexPathsForSelectedItems?.first {
            let selectedPhotoModel = viewController.photos[selectedIndexPath.row]
            let showDetailViewController = segue.destination as! PhotoDetailViewController
            
            showDetailViewController.presenter.saveSelectedPhotoModel(selectedPhotoModel)
        }
    }
    
}
