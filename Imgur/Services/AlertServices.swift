//
//  AlertServices.swift
//  Imgur
//
//  Created by Tom on 24/04/2018.
//  Copyright © 2018 Tom. All rights reserved.
//

import UIKit

class AlertServices {
    
    private init(){}

    static func subscribeAlert(in vc: UIViewController){
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let camera = UIAlertAction(title: "Camera", style: .default) { (_) in
            
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = vc as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
                imagePicker.sourceType = .camera;
                imagePicker.allowsEditing = false
                vc.present(imagePicker, animated: true, completion: nil)
                
            }
            
        }
        let gallery = UIAlertAction(title: "Gallery", style: .default) { (_) in
            
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = vc as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
                imagePicker.sourceType = .photoLibrary;
                imagePicker.allowsEditing = true
                vc.present(imagePicker, animated: true, completion: nil)
                
                
            }
            
        }
        alert.addAction(camera)
        alert.addAction(gallery)
        vc.present(alert, animated: true)
    }
    
}
