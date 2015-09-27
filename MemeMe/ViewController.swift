//
//  ViewController.swift
//  MemeMe
//
//  Created by Ricardo Boccato Alves on 9/19/15.
//  Copyright © 2015 Ricardo Boccato Alves. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var btnCamera: UIBarButtonItem!
    @IBOutlet weak var btnShare: UIBarButtonItem!
    @IBOutlet weak var edtBottom: UITextField!
    @IBOutlet weak var edtTop: UITextField!
    
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var toolBar: UIToolbar!
    
    var memedImage: UIImage!
    
    let memeTextAttributes = [
        NSStrokeColorAttributeName: UIColor.blackColor(),
        NSForegroundColorAttributeName: UIColor.whiteColor(),
        NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName: 4
    ]
    
    func initTextField(textField: UITextField) {
        textField.delegate = self
        textField.defaultTextAttributes = memeTextAttributes
        textField.textAlignment = .Center
    }
    
    func reset() {
        btnCamera.enabled = UIImagePickerController.isSourceTypeAvailable(.Camera)
        btnShare.enabled = false
        edtBottom.text = "BOTTOM"
        edtTop.text = "TOP"
        imagePickerView.image = nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        initTextField(edtBottom)
        initTextField(edtTop)
        reset()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeToKeyboardNotifications()
    }

    @IBAction func cancelMeme(sender: UIBarButtonItem) {
        reset()
    }
    
    func pickAnImageFrom(sourceType: UIImagePickerControllerSourceType) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = sourceType
        self.presentViewController(picker, animated: true, completion: nil)
    }
    
    @IBAction func pickAnImageFromAlbum(sender: UIBarButtonItem) {
        pickAnImageFrom(.PhotoLibrary)
    }
    
    @IBAction func pickAnImageFromCamera(sender: UIBarButtonItem) {
        pickAnImageFrom(.Camera)
    }
    
    func save() {
        let meme = Meme(bottom: edtBottom.text!, top: edtTop.text!,
            image: imagePickerView.image!, memedImage: memedImage)
    }
    
    @IBAction func shareMemedImage(sender: UIBarButtonItem) {
        memedImage = generateMemedImage()
        let ctrl = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        ctrl.completionWithItemsHandler = {(_, completed: Bool, _, _) in
            if completed {
                self.save()
            }
        }
        self.presentViewController(ctrl, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imagePickerView.image = image
            btnShare.enabled = true
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.CGRectValue().height
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // Move the view when the keyboard covers the text field.
    func keyboardWillShow(notification: NSNotification) {
        if edtBottom.isFirstResponder() {
            self.view.frame.origin.y = -getKeyboardHeight(notification)
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y = 0
    }
    
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "keyboardWillShow:", object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "keyboardWillHide:", object: nil)
    }
    
    func generateMemedImage() -> UIImage {
        
        // Hide toolbar and navbar
        navBar.hidden = true
        toolBar.hidden = true
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        self.view.drawViewHierarchyInRect(self.view.frame, afterScreenUpdates: true)
        let memedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // Show toolbar and navbar
        navBar.hidden = false
        toolBar.hidden = false
        
        return memedImage
    }
}
