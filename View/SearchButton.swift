//
//  SearchButton.swift
//  OA
//
//  Created by 洪继伟 on 2021/12/2.
//

import UIKit

class SearchButton: UIButton {

    var palceHolder:String?{
        didSet{
            setTitle(palceHolder, for: UIControl.State.normal)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setTitleColor(UIColor.darkGray, for: UIControl.State.normal)
        setTitle("搜索：\(App_CompanyName)", for: UIControl.State.normal)
        
        let img = UIImage(named: "icon_search")
        setImage(img?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate), for: UIControl.State.normal)
        backgroundColor = AppColor_BG
        
        layer.cornerRadius = 5
        layer.masksToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        /*
        print("-----------")
        titleLabel?.frame.offsetInPlace(dx: -imageView!.bounds.width * 0.5, dy: 0)
        imageView?.frame.offsetInPlace(dx: titleLabel!.bounds.width * 0.5 , dy: 0)
        */
        
        // Swift中可以这样写
        titleLabel?.font = UIFont.systemFont(ofSize: 13)
        imageView?.tintColor = UIColor.gray
        
        titleLabel?.textColor = UIColor.gray
        imageView?.size = CGSize(width: 20, height: 20)
        imageView?.x =  10
        imageView?.centerY = titleLabel!.centerY
        titleLabel?.x = imageView!.width + 15.0

//        self.sizeToFit()
    }
}
