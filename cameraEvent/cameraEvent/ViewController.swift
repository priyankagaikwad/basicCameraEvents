//
//  ViewController.swift
//  cameraEvent
//
//  Created by Priyanka Gaikwad on 19/08/15.
//  Copyright © 2015 Priyanka Gaikwad. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
        let selectedImage : UIImage = image
        imageView.image = selectedImage
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        picker.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func capture(sender: AnyObject) {
        
        if (UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera))  {
            print("true")
            imagePicker.sourceType = .Camera
            imagePicker.allowsEditing = false
            presentViewController(imagePicker, animated: true){}
        }
        else{
            print("No camera")
        }
    }//capture
        
    @IBAction func openGallery(sender: AnyObject) {
        
        if (UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary))
        {
            print("true")
            imagePicker.sourceType = .PhotoLibrary
            imagePicker.allowsEditing = false
            presentViewController(imagePicker, animated: true){}
        }
        else{
            print("No camera")
        }
    }//openGallery
}

