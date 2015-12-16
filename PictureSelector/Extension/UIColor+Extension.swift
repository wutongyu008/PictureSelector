//
//  PictureSelectorViewController.swift
//  PictureSelector
//
//  Created by 裘明 on 15/9/20.
//  Copyright © 2015年 裘明. All rights reserved.
//

import UIKit

extension UIColor {
    
    class func randomColor() -> UIColor {
        
        // 0~255
        let r = CGFloat(random() % 256) / 255.0
        let g = CGFloat(random() % 256) / 255.0
        let b = CGFloat(random() % 256) / 255.0
        
        return UIColor(red: r, green: g, blue: b, alpha: 1.0)
    }
}
