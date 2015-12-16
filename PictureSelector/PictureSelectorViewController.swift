//
//  PictureSelectorViewController.swift
//  PictureSelector
//
//  Created by 裘明 on 15/9/20.
//  Copyright © 2015年 裘明. All rights reserved.
//

import UIKit

/// cell的可重用标识
private let PictureSelectorReusedID = "PictureSelectorReusedID"
/// 最大选择图片数量
private let PictureSelectorMaxCount = 9

class PictureSelectorViewController: UICollectionViewController, pictureSelectorCellDelegate {
    /// 照片数组
    private lazy var pictures = [UIImage]()
    /// 当前选中照片的索引
    private var currentIndex = 0
    
    // 初使化
    init() {
        let layout = UICollectionViewFlowLayout()
        super.init(collectionViewLayout: layout)
        
        layout.itemSize = CGSize(width: 80, height: 80)
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = UIColor.whiteColor()
        
        // 注册可重用cell
        collectionView?.registerClass(pictureSelectorCell.self , forCellWithReuseIdentifier: PictureSelectorReusedID)
        
    }
    
    // MARK: - UICollectionViewDateSource
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pictures.count + (pictures.count == PictureSelectorMaxCount ? 0 : 1)
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        // 1.寻找可重用cell
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(PictureSelectorReusedID, forIndexPath: indexPath) as! pictureSelectorCell
        
        cell.pictureDelegate = self
        
        // 2.给cell赋值
        cell.backgroundColor = UIColor.randomColor()
        cell.image = indexPath.item < pictures.count ? pictures[indexPath.item] : nil
        
        // 3.返回cell
        return cell
        
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        print(indexPath)
        // 1.判断能否访问相册
        if !UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary) {
            
            print("没有照片")
            return
        }
        // 2.记录用户当前选中的照片
        currentIndex = indexPath.item
        
        // 3.访问相册
        let vc = UIImagePickerController()
        
        vc.delegate = self
        
        presentViewController(vc, animated: true, completion: nil)
        
    }
    
    // MARK: - PictureSelectorCellDelegate
    private func pictureSelectorCellClickRemoveButton(cell: pictureSelectorCell) {
        
        // 1.根据cell获取当前的索引
        if let indexPath = collectionView?.indexPathForCell(cell) where indexPath.item < pictures.count {
            
            // 删除对应索引的图像
            pictures.removeAtIndex(indexPath.item)
            
            // 刷新视图
            collectionView?.reloadData()
        }
    }
    
    
}

extension PictureSelectorViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
        
        let scaleImage = image.scaleToWith(300)
        
        // 用户选中了一张照片时
        if currentIndex < pictures.count {
            
            pictures[currentIndex] = scaleImage
        } else {
            // 追加照片
            pictures.append(scaleImage)
        }
        
        // 刷新视图
        collectionView?.reloadData()
        
        dismissViewControllerAnimated(true, completion: nil)
        
        
    }
}

// 照片cell的协议
private protocol pictureSelectorCellDelegate: NSObjectProtocol {
    
    func pictureSelectorCellClickRemoveButton(cell: pictureSelectorCell)
}

private class pictureSelectorCell: UICollectionViewCell {
    
    var image: UIImage? {
        didSet {
            if image != nil {
                pictureButton.setImage(image, forState: UIControlState.Normal)
            } else {
                pictureButton.setImage(UIImage(named: "compose_pic_add"), forState: UIControlState.Normal)
            }
            // 如果没有图片，就隐藏删除按钮
            removeButton.hidden = (image == nil)
        }
    }
    // 定义代理协议
    weak var pictureDelegate: pictureSelectorCellDelegate?
    
    // 点击删除按钮
    @objc private func clickRemove() {
        pictureDelegate?.pictureSelectorCellClickRemoveButton(self)
    }
    
    // MARK: - 设置Cell
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        setupUI()
    }
    
    /// 设置界面
    private func setupUI() {
        // 1.添加控件
        contentView.addSubview(pictureButton)
        contentView.addSubview(removeButton)
        
        // 2.设置布局
        pictureButton.frame = bounds
        
        removeButton.translatesAutoresizingMaskIntoConstraints = false
        let viewDict = ["rb": removeButton]
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[rb]-0-|", options: [], metrics: nil, views: viewDict))
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[rb]", options: [], metrics: nil, views: viewDict))
        
        pictureButton.userInteractionEnabled = false
        
        removeButton.addTarget(self, action: "clickRemove", forControlEvents: UIControlEvents.TouchUpInside)
        
        pictureButton.imageView!.contentMode = UIViewContentMode.ScaleAspectFill
        
    }
    
    // MARK: - 懒加载
    /// 添加照片按钮
    private lazy var pictureButton: UIButton = UIButton(imageName: "compose_pic_add", backImageName: nil)
    /// 删除照片按钮
    private lazy var removeButton: UIButton = UIButton(imageName: "compose_photo_close", backImageName: nil)
    
}


