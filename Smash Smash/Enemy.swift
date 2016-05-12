//
//  Enemy.swift
//  Smash Smash
//
//  Created by Timothy Barrett on 5/11/16.
//  Copyright © 2016 Timothy Barrett. All rights reserved.
//

import UIKit
import SpriteKit
import UIImage_Resize
class Enemy: NSObject {
    private var image:UIImage?
    init(withImage image:UIImage) {
        self.image = image
    }
    
    func getSpriteImage() -> SKTexture? {
        if image != nil {
            let scaledImage = image!.resizedImageToSize(CGSizeMake(image!.size.width/2, image!.size.height/2))
            return SKTexture(image: scaledImage.imageByCroppingImage(CGSize(width: 1000.0, height: 1000.0)).roundImage())
        }

        print("Error: Could not resize image")
        return nil
    }
    
    func getEnemyImage() -> UIImage? {
        if image != nil {
            return image!.imageByCroppingImage(CGSize(width: 1000.0, height: 1000.0)).roundImage()
        }
        return nil
    }
}

extension UIImage
{
    func roundImage() -> UIImage
    {
        let newImage = self.copy() as! UIImage
        let cornerRadius = self.size.height/2
        UIGraphicsBeginImageContextWithOptions(self.size, false, 0.0)
        let bounds = CGRect(origin: CGPointZero, size: self.size)
        UIBezierPath(roundedRect: CGRectMake(0.0, 0.0, self.size.width, self.size.height), cornerRadius: cornerRadius).addClip()
        newImage.drawInRect(bounds)
        let finalImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return finalImage
    }
    
    func imageByCroppingImage(size : CGSize) -> UIImage
    {
        let refWidth : CGFloat = CGFloat(CGImageGetWidth(self.CGImage))
        let refHeight : CGFloat = CGFloat(CGImageGetHeight(self.CGImage))
        
        let x = (refWidth - size.width) / 2
        let y = (refHeight - size.height) / 2
        
        let cropRect = CGRectMake(x, y, size.height, size.width)
        let imageRef = CGImageCreateWithImageInRect(self.CGImage, cropRect)
        
        let cropped : UIImage = UIImage(CGImage: imageRef!, scale: 0, orientation: self.imageOrientation)
        
        
        return cropped
    }
    
}