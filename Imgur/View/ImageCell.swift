//
//  ImageCell.swift
//  Imgur
//
//  Created by Tom on 23/04/2018.
//  Copyright © 2018 Tom. All rights reserved.
//

import UIKit

class ImageCell: UICollectionViewCell {
    
    
    @IBOutlet weak var imageView: UIImageView!
    var ids: String = ""
    
    override func prepareForReuse() {
        imageView.image = nil
    }
    func configure(with imgur: ImgurData) {
        ids = imgur.id
        imgur.image { image in
            self.imageView.image = image
        }
        
    }
}
