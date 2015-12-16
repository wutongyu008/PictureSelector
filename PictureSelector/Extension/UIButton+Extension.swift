//
//  PictureSelectorViewController.swift
//  PictureSelector
//
//  Created by 裘明 on 15/9/20.
//  Copyright © 2015年 裘明. All rights reserved.
//

import UIKit

extension UIButton {
    
    /// 便利构造函数
    ///
    /// - parameter imageName:     图像名称
    /// - parameter backImageName: 背景图像名称
    ///
    /// - returns: UIButton
    /// - 备注：如果图像名称使用 "" 会抱错误 CUICatalog: Invalid asset name supplied:
    convenience init(imageName: String, backImageName: String?) {
        self.init()
        
        setImage(UIImage(named: imageName), forState: .Normal)
        setImage(UIImage(named: imageName + "_highlighted"), forState: .Highlighted)
        
        if let backImageName = backImageName {
            setBackgroundImage(UIImage(named: backImageName), forState: .Normal)
            setBackgroundImage(UIImage(named: backImageName + "_highlighted"), forState: .Highlighted)
        }
        
        // 会根据背景图片的大小调整尺寸
        sizeToFit()
    }
    
    /// 便利构造函数
    ///
    /// - parameter title:          title
    /// - parameter color:          color
    /// - parameter backImageName:  背景图像
    ///
    /// - returns: UIButton
    convenience init(title: String, color: UIColor, backImageName: String) {
        self.init()
        
        setTitle(title, forState: .Normal)
        setTitleColor(color, forState: .Normal)
        
        setBackgroundImage(UIImage(named: backImageName), forState: .Normal)
        
        sizeToFit()
    }
    
    /// 便利构造函数
    ///
    /// - parameter title:     title
    /// - parameter color:     color
    /// - parameter fontSize:  字体大小
    /// - parameter imageName: 图像名称
    /// - parameter backColor: 背景颜色（默认为nil）
    ///
    /// - returns: UIButton
    convenience init(title: String, fontSize: CGFloat, color: UIColor, imageName: String?, backColor: UIColor? = nil) {
        self.init()
        
        setTitle(title, forState: .Normal)
        setTitleColor(color, forState: .Normal)
        
        if let imageName = imageName {
            setImage(UIImage(named: imageName), forState: .Normal)
        }
        
        // 设置背景颜色
        backgroundColor = backColor
        
        titleLabel?.font = UIFont.systemFontOfSize(fontSize)
        
        sizeToFit()
    }
}
