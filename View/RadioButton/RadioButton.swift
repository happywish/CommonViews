//
//  RadioButton.swift
//  OA
//
//  Created by 洪继伟 on 2021/12/27.
//

import UIKit

class RadioButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setTitleColor(UIColor.darkGray, for: UIControl.State.normal)
        setImage(UIImage(named: "icon_success"), for: UIControl.State.normal)
        setImage(UIImage(named: "icon_success"), for: UIControl.State.selected)
        titleLabel?.font = UIFont.systemFont(ofSize: 14)
        self.imageView?.layer.cornerRadius = 10
        self.imageView?.layer.masksToBounds = true
        
        self.imageView?.backgroundColor = UIColor.white
        self.imageView?.layer.borderColor = AppColor_Border.cgColor
        self.imageView?.layer.borderWidth = 1

    }
    
    static let imageHeight = 20
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    @objc func click(){
//        self.isSelected = !self.isSelected
//    }
    
    override var isSelected: Bool
    {
        didSet{
            if isSelected {
                self.imageView?.backgroundColor = AppColor_Blue
                self.imageView?.layer.borderWidth = 0
            }
            else{
                self.imageView?.backgroundColor = UIColor.white
                self.imageView?.layer.borderColor = AppColor_Border.cgColor
                self.imageView?.layer.borderWidth = 1
            }
        }
    }
    
//    override func select(_ sender: Any?) {
//        super.select(sender)
//
//        if self.isSelected {
//            self.imageView?.backgroundColor = AppColor_Blue
//            self.imageView?.layer.borderWidth = 0
//        }
//        else{
//            self.imageView?.backgroundColor = UIColor.white
//            self.imageView?.layer.borderColor = AppColor_Border.cgColor
//            self.imageView?.layer.borderWidth = 1
//        }
//    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        /*
        print("-----------")
        titleLabel?.frame.offsetInPlace(dx: -imageView!.bounds.width * 0.5, dy: 0)
        imageView?.frame.offsetInPlace(dx: titleLabel!.bounds.width * 0.5 , dy: 0)
        */
        
        // Swift中可以这样写
//        titleLabel?.frame.origin.x = 0
//        imageView?.frame.origin.x = titleLabel!.frame.size.width
        imageView?.size = CGSize(width: RadioButton.imageHeight, height: RadioButton.imageHeight)
        imageView?.centerY = titleLabel!.centerY
        self.sizeToFit()
    }
}
