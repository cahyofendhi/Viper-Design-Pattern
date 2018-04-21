//
//  Loan.swift
//  ViperFlick
//
//  Created by Rumah Ulya on 17/04/18.
//  Copyright © 2018 Rumah Ulya. All rights reserved.
//

import Foundation

struct Flickr: Codable {
    let photos: Photosa?
    let stat: String?
}

struct Photosa: Codable {
    let page, pages, perpage: Int?
    let total: String?
    let photo: [FlickrPhotoModel]?
}

struct FlickrPhotoModel: Codable {
    
    let id: String
    let farm: Int
    let secret: String
    let server: String
    let title: String
    
    var photoUrl: NSURL {
        return flickrImageURL()
    }
    
    var largePhotoUrl: NSURL {
        return flickrImageURL(size: "b")
    }
    
    private func flickrImageURL(size: String = "m") -> NSURL {
        return NSURL(string: "https://farm\(farm).staticflickr.com/\(server)/\(id)_\(secret)_\(size).jpg")!
    }
}
