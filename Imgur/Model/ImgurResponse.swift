//
//  ImgurResponse.swift
//  Imgur
//
//  Created by Tom on 24/04/2018.
//  Copyright © 2018 Tom. All rights reserved.
//
import Foundation

struct ImgursResponse {
    
    let imgurs: [ImgurData]
    
    init(json: JSON) throws {
        guard let data = json["data"] as? [JSON] else { throw ConnectionError.someError }
        let imgurs = data.map{ ImgurData(json: $0) }.compactMap{ $0 }
        self.imgurs = imgurs
    }
}
