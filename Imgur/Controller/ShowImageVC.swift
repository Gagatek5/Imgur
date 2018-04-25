//
//  ShowImageVC.swift
//  Imgur
//
//  Created by Tom on 23/04/2018.
//  Copyright © 2018 Tom. All rights reserved.
//

import UIKit

class ShowImageVC: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var ImageCollection: UICollectionView!
    
    var deleteImageId = ""
    var imgurs = [ImgurData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createUI()
        ImgurAPIConnector.shared.getImgurs { (response) in
            self.imgurs = response.imgurs
            self.ImageCollection.reloadData()
        }
    }
    //UICreator code:
    func createUI() {
        let screenSize: CGRect = UIScreen.main.bounds
        
        //navBar
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 16, width: screenSize.width, height: 44))
        let navItem = UINavigationItem(title: "Imgur")
        let remove = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.trash, target: nil, action: #selector(DeleteImageButton))
        let add = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: nil, action: #selector(AddImageButton))
        navItem.rightBarButtonItem = remove
        navItem.leftBarButtonItem = add
        navBar.setItems([navItem], animated: false)
        self.view.addSubview(navBar)
        
    }
    //Refresh Tabel
    func refresh() {
        sleep(1)
        ImgurAPIConnector.shared.getImgurs { (response) in
            self.imgurs = response.imgurs
            self.ImageCollection.reloadData()
        }
    }
    //ImageSelector
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        let imageData: NSData = UIImagePNGRepresentation(image)! as NSData
        ImgurAPIConnector.shared.AddImgurs(data: imageData, success: { (response)  in})
        refresh()
        dismiss(animated:true, completion: nil)
    }
    //Buttons code:
    @IBAction func AddImageButton(_ sender: AnyObject) {
        AlertServices.subscribeAlert(in: self)
        refresh()
    }
    @IBAction func DeleteImageButton(_ sender: Any) {
        ImgurAPIConnector.shared.removeImgurs(imageHash: deleteImageId, success: { (response)  in})
        refresh()
    }
    //CollectionView code:
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imgurs.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as? ImageCell else { return UICollectionViewCell() }
        
        cell.configure(with: imgurs[indexPath.item])
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell : ImageCell = collectionView.cellForItem(at: indexPath)! as! ImageCell
        deleteImageId =  cell.ids
    }
}


