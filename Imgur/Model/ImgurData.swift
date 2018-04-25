//
//  ImgurData.swift
//  Imgur
//
//  Created by Tom on 24/04/2018.
//  Copyright © 2018 Tom. All rights reserved.
//
import UIKit

struct ImgurData {
    
    let imageLink: String
    let id: String
    
    init?(json: JSON) {
        guard let id = json["id"] as? String,
            let imageLink = json["link"] as? String
            else { return nil }
        self.id = id
        self.imageLink = imageLink
    }
    
    func image(completion: @escaping (UIImage) -> Void) {
        if let image = imageCache.image(forKey: id) {
            completion(image)
        } else {
            ImgurAPIConnector.shared.downloadImage(link: imageLink) { (image) in
                imageCache.add(image, forKey: self.id)
                completion(image)
            }
        }
    }
}
