//
//  CustomImageView.swift
//  Daily Readings
//
//  Created by PoGo on 11/3/17.
//  Copyright © 2017 PoGo. All rights reserved.
//

import UIKit

var imageCache = NSCache<AnyObject, AnyObject>()

class CustomImageVIew: UIImageView {
    
    var lastUrlUsedToLoadImage: String?
    
    func loadImagesUsingCacheWithUrlString(_ urlString: String){
        lastUrlUsedToLoadImage = urlString
        self.image = nil
        //check cache for image first
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage{
            DispatchQueue.main.async {
                self.image = imageFromCache
                return
            }
        }else {
            //otherwise fire off a new download
            guard let url = URL(string: urlString) else {return}
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                if error != nil{
                    DispatchQueue.main.async {
                        self.image = #imageLiteral(resourceName: "noInternetImage")
                    }
                    
                    print("Can't get image in Cache")
                    return
                }
                
                if url.absoluteString != self.lastUrlUsedToLoadImage{
                    return
                }                    
                    DispatchQueue.main.async {
                        guard let imageData = data else {return}
                        if let downloadedImage = UIImage(data: imageData) {
                        imageCache.setObject(downloadedImage, forKey: urlString as AnyObject)
                        self.image = downloadedImage
                    }
                    
                }
                
            }).resume()
        }

}

}
