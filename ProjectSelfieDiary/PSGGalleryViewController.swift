//
//  PSGGalleryViewController.swift
//  ProjectSelfieDiary
//
//  Created by Abbin Varghese on 28/11/16.
//  Copyright © 2016 Abbin Varghese. All rights reserved.
//

import UIKit
import PINCache

class PSGGalleryViewController: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    let galleryCache = PINCache.init(name: Constants.GalleryCacheName)
    var imageArray :NSMutableArray? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageArray = galleryCache.object(forKey: Constants.GalleryimageArray) as? NSMutableArray
        print(imageArray ?? "asd")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismissGallery(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count : Int = (imageArray?.count){
            return count
        }
        else{
            return 0;
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PSDGalleryCollectionViewCell",
                                                      for: indexPath) as! PSDGalleryCollectionViewCell
        cell.cellImageView.image = imageArray?.object(at: indexPath.row) as! UIImage?
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: collectionView.frame.size.width/2-4, height: collectionView.frame.size.width/2-4)
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
