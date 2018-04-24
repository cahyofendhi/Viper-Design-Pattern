//
//  FlickrDataManager.swift
//  ViperFlick
//
//  Created by Rumah Ulya on 10/04/18.
//  Copyright © 2018 Rumah Ulya. All rights reserved.
//

import Foundation
import SDWebImage
import Alamofire

protocol FlickrSearchPhotoProtocol: class {
    func fetchPhotosForSearchText(searchText: String, page: NSInteger, clousure: @escaping (NSError?, NSInteger, [FlickrPhotoModel]?) -> Void) -> Void
}

protocol FlickrPhotoLoadImageProtocol: class {
    func  loadImageFromUrl(_ url: NSURL, closure: @escaping (UIImage?, NSError?) -> Void)
}

class FlickrDataManager: FlickrSearchPhotoProtocol, FlickrPhotoLoadImageProtocol {
    
    static let sharedInstance = FlickrDataManager()
    
    func fetchPhotosForSearchText(searchText: String, page: NSInteger, clousure: @escaping (NSError?, NSInteger, [FlickrPhotoModel]?) -> Void) -> Void {
        
        let searchFormatUrl = ENDPOINT+"?method=flickr.photos.search&api_key=\(APIKey)&tags=\(searchText)&page=\(page)&format=json&nojsoncallback=1"
        
        print("Url \(searchFormatUrl)")
        APIManager.getFrom(
            searchFormatUrl,
            method: .get,
            parameters: [:],
            encoding: JSONEncoding.default,
            headers: [:],
            completion: { response in
                
                let decoder = JSONDecoder()
                guard let callback = try? decoder.decode(Flickr.self, from: response) else {
                    print("ERROR: parsing)")
                    clousure(nil, 0, nil)
                    return
                }
                let photos = callback.photos
                guard let total = Int((photos?.total)!) else {
                    clousure(nil, 0, nil)
                    return
                }
                clousure(nil, total, photos?.photo)
        }) { error in
            print("ERROR: \(error)")
            clousure(nil, 0, nil)
        }
    }

    
    func loadImageFromUrl(_ url: NSURL, closure: @escaping (UIImage?, NSError?) -> Void){
        SDWebImageManager.shared().loadImage(with: url as URL, options: .cacheMemoryOnly, progress: nil) { (image, data, error, imageCachetype, finished, withUrl) in
            if ((image != nil) && finished){
                closure(image, error! as NSError)
            }
        }
    }
    
    func getError() -> String {
        return "ERROR: Parsing json error"
    }
    
    
}
