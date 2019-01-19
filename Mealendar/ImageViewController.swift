//
//  ImageViewController.swift
//  Mealendar
//
//  Created by Hideaki Ito on 2019/01/19.
//  Copyright © 2019 Hideaki Ito. All rights reserved.
//
//  Referred to https://gigazine.net/news/20180125-make-ios-app-image-picker/
//

import UIKit

class ImageViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!

    @IBAction func selectImage(_ sender: UITapGestureRecognizer) {
        let pickerController = UIImagePickerController()
        
        pickerController.sourceType = .photoLibrary
        pickerController.delegate = self
        
        present(pickerController, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {fatalError("imagePickerController error: ¥(info)¥n")}
        
        imageView.image = selectedImage
        
        dismiss(animated: true, completion: nil)
    }
}
