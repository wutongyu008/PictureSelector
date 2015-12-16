//
//  PictureSelectorViewController.swift
//  PictureSelector
//
//  Created by 裘明 on 15/9/20.
//  Copyright © 2015年 裘明. All rights reserved.
//

import UIKit

extension UIImageView {
    
    /// 便利构造函数
    ///
    /// - parameter imageName: imageName
    ///
    /// - returns: UIImageView
    convenience init(imageName: String) {
        self.init(image: UIImage(named: imageName))
    }
}
