//
//  RowButtonView.swift
//  OA
//  行按钮
//  包含图标、标题、箭头、下划线
//  Created by 洪继伟 on 2021/11/26.
//

import UIKit
import SnapKit

class RowArrowButton: UIButton {
    
    lazy var iconView: UIImageView = {
        let temp = UIImageView()
        return temp
    }()
    
    lazy var titleView: UILabel = {
        let temp = UILabel()
        temp.font = UIFont.systemFont(ofSize: 15)
        temp.textColor = TEXT_COLOR_BLACK_87
        return temp
    }()
    
    lazy var arrowView: UIImageView = {

        let temp = UIImageView(image: UIImage(named: "icon_arrow_right"))
        temp.tintColor = UIColor.gray
        return temp
    }()
    
    lazy var borderBottom: UIView = {
        let temp = UIView()
        temp.backgroundColor = AppColor_Border
        return temp
    }()
    
    var showBorder:Bool = false {
        didSet{
            borderBottom.isHidden = !showBorder
        }
    }
    
    var title :String = "" {
        didSet{
            titleView.text = title
        }
    }
    
    var icon:String = "" {
        didSet{
            iconView.image  = UIImage(named: icon)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setBackgroundImage(UIImage.imageWithColor(color: UIColor.white), for: UIControl.State.normal)
        setBackgroundImage(UIImage.imageWithColor(color: AppColor_BG), for: UIControl.State.highlighted)
        
        addSubview(iconView)
        iconView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(26)
            make.height.width.equalTo(26)
            make.centerY.equalToSuperview()
        }
        
        addSubview(titleView)
        titleView.snp.makeConstraints { make in
            make.left.equalTo(iconView.snp.right).offset(2)
            make.centerY.equalToSuperview()
        }
        
        addSubview(arrowView)
        arrowView.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-20)
            make.height.width.equalTo(20)
            make.centerY.equalToSuperview()
        }
        
        addSubview(borderBottom)
        borderBottom.snp.makeConstraints { make in
            make.left.equalTo(titleView)
            make.right.equalToSuperview()
            make.height.equalTo(1)
            make.bottom.equalToSuperview()
            
            borderBottom.isHidden=true
        }
        
    }
    
    class func rowButton(title:String,icon:String,border:Bool)->RowArrowButton {
        
        let rowButtonView = RowArrowButton()
        rowButtonView.title = title
        rowButtonView.icon=icon
        rowButtonView.showBorder = border
        return rowButtonView
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}
