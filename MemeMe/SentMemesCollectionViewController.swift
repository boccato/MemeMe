//
//  SentMemesCollectionViewController.swift
//  MemeMe
//
//  Created by Ricardo Boccato Alves on 10/4/15.
//  Copyright © 2015 Ricardo Boccato Alves. All rights reserved.
//

import Foundation
import UIKit

class SentMemesCollectionViewController: UICollectionViewController {
    var memes: [Meme] {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MemeCell", forIndexPath: indexPath) as UICollectionViewCell
        cell.backgroundView = UIImageView(image: memes[indexPath.item].memedImage)
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.collectionView!.reloadData()
    }
}
