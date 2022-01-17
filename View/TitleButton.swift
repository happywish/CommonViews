//
//  TitleButton.swift
//  DSWeibo
//
//  Created by xiaomage on 15/9/7.
//  Copyright © 2015年 小码哥. All rights reserved.
//

import UIKit

class TitleButton: UIButton {

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setTitleColor(UIColor.darkGray, for: UIControl.State.normal)
        setImage(UIImage(named: "navigationbar_arrow_down"), for: UIControl.State.normal)
        setImage(UIImage(named: "navigationbar_arrow_up"), for: UIControl.State.selected)

  
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
        titleLabel?.frame.origin.x = 0
        imageView?.frame.origin.x = titleLabel!.frame.size.width
        self.sizeToFit()
    }
}
