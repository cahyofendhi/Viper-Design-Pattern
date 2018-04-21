//
//  PhotoItemCell.swift
//  ViperFlick
//
//  Created by Rumah Ulya on 13/04/18.
//  Copyright © 2018 Rumah Ulya. All rights reserved.
//

import UIKit

class PhotoItemCell: UICollectionViewCell, ReuseIdentifierProtocol {
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    override func awakeFromNib() {
        self.contentView.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
    }
}
