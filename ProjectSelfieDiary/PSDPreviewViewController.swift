//
//  PSDPreviewViewController.swift
//  ProjectSelfieDiary
//
//  Created by Abbin Varghese on 28/11/16.
//  Copyright © 2016 Abbin Varghese. All rights reserved.
//

import UIKit
import Photos
import PINCache

class PSDPreviewViewController: UIViewController {
    
    var previewImageData: Data?
    let cache = PINCache.init(name: Constants.SettingsCacheName)
    let galleryCache = PINCache.init(name: Constants.GalleryCacheName)
    
    @IBOutlet weak var previewImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let convertedImage = UIImage.init(data: previewImageData!)
        let flipedImage = UIImage.init(cgImage: (convertedImage?.cgImage!)!, scale: (convertedImage?.scale)!, orientation: .leftMirrored)
        previewImageView.image = flipedImage
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismissWithoutSaving(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func dismissAndSave(_ sender: UIButton) {
        self.dismiss(animated: true, completion: {
            DispatchQueue.global(qos: .background).async {
                self.saveToPhotoLibrary()
                let image :UIImage = self.previewImageView.image!
                
                if let imageArray :NSMutableArray = self.galleryCache.object(forKey: Constants.GalleryimageArray) as? NSMutableArray{
                    imageArray.add(image)
                    self.galleryCache.setObject(imageArray, forKey: Constants.GalleryimageArray)
                }
                else{
                    let imageArray :NSMutableArray = [image]
                    self.galleryCache.setObject(imageArray, forKey: Constants.GalleryimageArray)
                }
            }
        })
    }
    
    func saveToPhotoLibrary(){
        let saveMediaSetting :SaveMediaSettings.RawValue = self.cache.object(forKey: Constants.SaveMediaSettings) as! SaveMediaSettings.RawValue
        
        if saveMediaSetting == SaveMediaSettings.SaveImagesIntoPhotos.rawValue {
            
            let doublFlipedImage = UIImage.init(cgImage: (self.previewImageView.image?.cgImage!)!, scale: (self.previewImageView.image?.scale)!, orientation: .rightMirrored)
            let convertedData = UIImageJPEGRepresentation(doublFlipedImage, 1)
            PHPhotoLibrary.requestAuthorization { status in
                if status == .authorized {
                    PHPhotoLibrary.shared().performChanges({
                        let creationRequest = PHAssetCreationRequest.forAsset()
                        creationRequest.addResource(with: .photo, data: convertedData!, options: nil)
                        
                    }, completionHandler: { success, error in
                        if let error = error {
                            print("Error occurered while saving photo to photo library: \(error)")
                        }
                    }
                    )
                }
            }
        }

    }
}

