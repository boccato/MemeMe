//
//  ViewController.swift
//  MemeMe
//
//  Created by Ricardo Boccato Alves on 9/19/15.
//  Copyright © 2015 Ricardo Boccato Alves. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var btnCamera: UIBarButtonItem!
    @IBOutlet weak var edtBottom: UITextField!
    @IBOutlet weak var edtTop: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        btnCamera.enabled = UIImagePickerController.isSourceTypeAvailable(.Camera)
        let memeTextAttributes = [
            NSStrokeColorAttributeName: UIColor.blackColor(),
            NSForegroundColorAttributeName: UIColor.whiteColor(),
            NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSStrokeWidthAttributeName: 2
        ]
        edtBottom.defaultTextAttributes = memeTextAttributes
        edtTop.defaultTextAttributes = memeTextAttributes
        
        edtBottom.textAlignment = .Center
        edtTop.textAlignment = .Center
        
        edtBottom.text = "BOTTOM"
        edtTop.text = "TOP"
    }

    @IBAction func pickAnImageFromAlbum(sender: UIBarButtonItem) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .SavedPhotosAlbum
        self.presentViewController(picker, animated: true, completion: nil)
    }
    
    @IBAction func pickAnImageFromCamera(sender: UIBarButtonItem) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .Camera
        self.presentViewController(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.imagePickerView.image = image
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}
