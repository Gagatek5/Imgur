//
//  ImgurAPIConnector.swift
//  Imgur
//
//  Created by Tom on 24/04/2018.
//  Copyright © 2018 Tom. All rights reserved.
//

import UIKit

typealias JSON = [String: Any]

class ImgurAPIConnector {
    
    static let shared = ImgurAPIConnector()
    private init() {}
    
    func getImgurs(success successBlock: @escaping (ImgursResponse) -> Void) {
        guard let url = URL(string: "https://api.imgur.com/3/account/TomekTwa/images") else { return }
        var request = URLRequest(url: url)
        request.addValue("Bearer 0b9e764c56b1a57dfa7d0e4f2731e1b3cb3cd438", forHTTPHeaderField: "Authorization")
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, _, _) in
            guard let data = data else { return }
            do {
                guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? JSON else { return }
                let getImgursResponse = try ImgursResponse(json: json)
                DispatchQueue.main.async {
                    successBlock(getImgursResponse)
                }
            } catch {}
            }.resume()
    }
    func removeImgurs(imageHash: String, success successBlock: @escaping (ImgursResponse) -> Void) {
        
        guard let url = URL(string: "https://api.imgur.com/3/image/\(imageHash)") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.addValue("Bearer 0b9e764c56b1a57dfa7d0e4f2731e1b3cb3cd438", forHTTPHeaderField: "Authorization")
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, _, _) in
            guard let data = data else { return }
            do {
                guard (try JSONSerialization.jsonObject(with: data, options: []) as? JSON) != nil else { return }
            } catch {}
            }.resume()
    }
    func AddImgurs(data: NSData, success successBlock: @escaping (ImgursResponse) -> Void) {
        
        guard let url = URL(string: "https://api.imgur.com/3/image") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("Bearer 0b9e764c56b1a57dfa7d0e4f2731e1b3cb3cd438", forHTTPHeaderField: "Authorization")
        request.httpBody = data.base64EncodedData(options: .lineLength64Characters)

        let session = URLSession.shared
        session.dataTask(with: request) { (data, _, _) in
            guard let data = data else { return }
            do {
                guard (try JSONSerialization.jsonObject(with: data, options: []) as? JSON) != nil else { return }
            } catch {}
            }.resume()
    }
    func downloadImage(link: String, success successBlock: @escaping (UIImage) -> Void) {
        guard let url = URL(string: link) else { return }
        let session = URLSession.shared
        session.dataTask(with: url) { (data, _, _) in
            guard let data = data,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async {
                successBlock(image)
            }
            }.resume()
    }
}

enum ConnectionError: Error {
    case someError
}

