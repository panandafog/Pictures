//
//  UIImage+Extensions.swift
//  Pictures
//
//  Created by Andrey on 20.05.2023.
//

import UIKit

extension UIImage {
    
    var resizedForTabBar: UIImage { resized(to: CGSize(width: 30, height: 30)) }
    
    func resized(to targetSize: CGSize) -> UIImage {
       let widthRatio  = targetSize.width  / size.width
       let heightRatio = targetSize.height / size.height
       
       var newSize: CGSize
       if(widthRatio > heightRatio) {
           newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
       } else {
           newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
       }
       
       let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
       
       UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
       draw(in: rect)
        
       let newImage = UIGraphicsGetImageFromCurrentImageContext()
       UIGraphicsEndImageContext()
       
       return newImage!
   }
}
