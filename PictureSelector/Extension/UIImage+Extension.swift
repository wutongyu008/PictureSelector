//
//  UIImage+Extension.swift
//  01-照片选择
//
//  Created by male on 15/10/26.
//  Copyright © 2015年 itheima. All rights reserved.
//

import UIKit

extension UIImage {
    
    /// 将图像缩放到指定`宽度`
    ///
    /// - parameter width: 目标宽度
    ///
    /// - returns: 如果给定的图片宽度小于指定宽度，直接返回
    func scaleToWith(width: CGFloat) -> UIImage {
     
        // 1. 判断宽度
        if width > size.width {
            return self
        }
        
        // 2. 计算比例
        let height = size.height * width / size.width
        let rect = CGRect(x: 0, y: 0, width: width, height: height)
        
        // 3. 使用核心绘图绘制新的图像
        // 1> 开启上下文
        UIGraphicsBeginImageContext(rect.size)
        
        // 2> 绘图 - 在指定区域拉伸绘制
        self.drawInRect(rect)
        
        // 3> 取结果
        let result = UIGraphicsGetImageFromCurrentImageContext()
        
        // 4> 关闭上下文
        UIGraphicsEndImageContext()
        
        // 5> 返回结果
        return result
    }
    
}