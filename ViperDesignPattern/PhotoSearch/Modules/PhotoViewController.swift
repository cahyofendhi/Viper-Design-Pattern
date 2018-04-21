//
//  PhotoViewController.swift
//  ViperFlick
//
//  Created by Rumah Ulya on 10/04/18.
//  Copyright © 2018 Rumah Ulya. All rights reserved.
//

import UIKit
import Alamofire

protocol PhotoViewControllerOutput {
    func fetchphotos(_ searchtag: String, page: NSInteger)
    func gotoPhotoDetailScreen()
    func pastDataToNextScene(_ segue: UIStoryboardSegue)
}

protocol PhotoViewControllerInput {
    func displayFetchedPhotos(_ photos: [FlickrPhotoModel], totalpages: NSInteger)
    func displayErrorView(_ errorMessage: String)
    func showWaitingView()
    func hideWaitingView()
    func getTotalPhoneCount() -> NSInteger
}

class PhotoViewController: UIViewController, PhotoViewControllerInput {
    
    @IBOutlet weak var photoCollectionView: UICollectionView!
    
    var presenter: PhotoViewControllerOutput!
    
    var photos: [FlickrPhotoModel] = []
    var currentPage = 1
    var totalPages  = 1
    
    override func awakeFromNib() {
        super.awakeFromNib()
        PhotoSearchAssembly.sharedInstance.configure(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.title  = photoSearchKey
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        performSearchWith(photoSearchKey)
    }
    
    func performSearchWith(_ searchText: String) {
        presenter.fetchphotos(searchText, page: currentPage)
    }
    
    func displayFetchedPhotos(_ photos: [FlickrPhotoModel], totalpages: NSInteger) {
        self.photos.append(contentsOf: photos)
        self.totalPages = totalpages
        
        DispatchQueue.main.async {
            self.photoCollectionView.reloadData()
        }
    }
    
    // show error
    func displayErrorView(_ errorMessage: String){
        let refreshAlert = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
        refreshAlert.addAction(UIAlertAction(title: okay, style: .default, handler: { (action) in
            refreshAlert.dismiss(animated: true, completion: nil)
        }))
        
        present(refreshAlert, animated: true, completion: nil)
    }
    
    // MARK:- ActivityView
    func showWaitingView() {
        let alert = UIAlertController(title: nil, message: waitingKey, preferredStyle: .alert)
        alert.view.tintColor = UIColor.black
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50)) as UIActivityIndicatorView
        
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.activityIndicatorViewStyle = .gray
        loadingIndicator.startAnimating()
        
        alert.view.addSubview(loadingIndicator)
        self.navigationController?.present(alert, animated: true, completion: nil)
    }
    
    func hideWaitingView() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func getTotalPhoneCount() -> NSInteger {
        return self.photos.count
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        presenter.pastDataToNextScene(segue)
    }
    
}

extension PhotoViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if currentPage < totalPages { // photo cell + loading cell
            return photos.count + 1
        }
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row < photos.count {
            return photoItemCell(collectionView, cellForItemAt: indexPath as NSIndexPath)
        } else {
            currentPage += 1
            performSearchWith(photoSearchKey)
            return loadingItemCell(collectionView, cellForItemAt: indexPath as NSIndexPath)
        }
    }
    
    func photoItemCell(_ collectionView: UICollectionView, cellForItemAt indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoItemCell.defaultReuseIdentifier, for: indexPath as IndexPath) as! PhotoItemCell
        
        let flickphoto  = self.photos[indexPath.row]
        
        cell.photoImageView.alpha = 0
        cell.photoImageView.setImageUrl(url: flickphoto.photoUrl as URL)
        
        return cell
    }
    
    func loadingItemCell(_ collectionView: UICollectionView, cellForItemAt indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoLoadingCell.defaultReuseIdentifier, for: indexPath as IndexPath) as! PhotoLoadingCell
        return cell
    }
    
}

extension PhotoViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.presenter.gotoPhotoDetailScreen()
    }
}

extension PhotoViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var itemSize: CGSize
        let length = UIScreen.main.bounds.width / 3 - 1
        
        if indexPath.row < photos.count {
            itemSize = CGSize(width: length, height: length)
        } else {
            itemSize = CGSize(width: photoCollectionView.bounds.width, height: 50.0)
        }
        
        return itemSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.5
    }
    
}












