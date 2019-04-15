//
//  CustomImage.swift
//  Think360
//
//  Created by admin on 15/04/19.
//  Copyright © 2019 AcknoTech. All rights reserved.
//

import UIKit

private let imageCache = NSCache<AnyObject, AnyObject>()

class CustomImageView:UIImageView{
    var imageUrlString:String?
    
    func loadImageUsingURLString(urlString:String){
        imageUrlString = urlString
        
        guard let url = URL(string: urlString) else{return}
        
        image = nil
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage{
            self.image = imageFromCache
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil{
                print(error.debugDescription)
                return
            }
            
            
            DispatchQueue.main.async {
                let imageToCache = UIImage(data: data!)
                
                if self.imageUrlString == urlString{
                    self.image = imageToCache
                }
                
                imageCache.setObject(imageToCache!, forKey: urlString as AnyObject)
            }
            }.resume()
    }
}
