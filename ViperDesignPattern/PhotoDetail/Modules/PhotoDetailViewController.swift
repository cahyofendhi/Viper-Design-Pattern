//
//  PhotoDetailViewController.swift
//  ViperFlick
//
//  Created by Rumah Ulya on 10/04/18.
//  Copyright © 2018 Rumah Ulya. All rights reserved.
//

import UIKit


protocol PhotoDetailViewControllerInput: class {
    func addLargeLoadedPhoto(_ photo: URL)
    func addPhotoImageTitle(_ title: String)
}

protocol PhotoDetailViewControllerOutput: class {
    func saveSelectedPhotoModel(_ photoModel: FlickrPhotoModel)
    func loadLargePhotoImage()
    func getPhotoImageTitle()
}

class PhotoDetailViewController: UIViewController, PhotoDetailViewControllerInput {

    @IBOutlet weak var photoTitleLable: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    
    var presenter: PhotoDetailViewControllerOutput!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        PhotoDetailAssembly.sharedInstance.configure(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ask title and image from presenter
        self.presenter.getPhotoImageTitle()
        self.presenter.loadLargePhotoImage()
    }

    // result comes from presenter
    func addLargeLoadedPhoto(_ photo: URL) {
        self.photoImageView.setImageUrl(url: photo)
    }
    
    func addPhotoImageTitle(_ title: String) {
        self.photoTitleLable.text = title
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
