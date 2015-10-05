//
//  MemeDetailViewController.swift
//  MemeMe
//
//  Created by Ricardo Boccato Alves on 10/4/15.
//  Copyright © 2015 Ricardo Boccato Alves. All rights reserved.
//

import Foundation
import UIKit

class MemeDetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    var meme: Meme!
    var index: Int!
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        imageView!.image = meme.memedImage
    }    
}
