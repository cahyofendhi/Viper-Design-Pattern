//
//  extention.swift
//  ViperFlick
//
//  Created by Rumah Ulya on 13/04/18.
//  Copyright © 2018 Rumah Ulya. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func setImageUrl(url: URL) {
        self.sd_setImage(with: url, placeholderImage: nil, options: .cacheMemoryOnly, progress: nil) { (image, error, cache, url) in
            self.image = image
            UIView.animate(withDuration: 0.2, animations: {
                self.alpha = 1.0
            })
        }
    }
    
}
