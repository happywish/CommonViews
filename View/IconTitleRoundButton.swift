//
//  ImageButton.swift
//  OA
//  图标-标题按钮 圆形
//  Created by 洪继伟 on 2021/12/1.
//

import UIKit

class IconTitleRoundButton: UIButton {

    lazy var customerTitleLabel: UILabel = {
        let temp = UILabel()
        temp.font = UIFont.systemFont(ofSize: 14)
        temp.textColor = TEXT_COLOR_BLACK_68
        return temp
    }()
    
    lazy var iconContainer: UIView = {
        let temp = UIView()
        temp.layer.cornerRadius = CGFloat(IconTitleRoundButton.btnWidth/2)
        temp.layer.masksToBounds = true
        temp.backgroundColor = AppColor_Blue
        temp.isUserInteractionEnabled = false
        return temp
    }()
    
    lazy var iconView: UIImageView = {
        let temp = UIImageView()
        temp.isUserInteractionEnabled = false
        
        return temp
    }()
    
    var title:String? {
        didSet{
            customerTitleLabel.text = title
        }
    }
    
    var iconColor:UIColor = AppColor_Blue{
        didSet{
            iconContainer.backgroundColor = iconColor
        }
    }
    
    var icon:String?{
        didSet{
            if let _icon = icon{
                iconView.image = UIImage(named: _icon)
            }
        }
    }
    
    var vcName:String?
    
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        addSubview(iconContainer)
        iconContainer.addSubview(iconView)
        addSubview(customerTitleLabel)
        
        iconContainer.snp.makeConstraints { make in
            make.width.equalTo(IconTitleRoundButton.btnWidth)
            make.height.equalTo(IconTitleRoundButton.btnWidth)
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        iconView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(32)
        }
        
        customerTitleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(iconContainer.snp.bottom).offset(7)
           
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    class func iconTitleButton(title:String,icon:String,iconColor:UIColor)->IconTitleRoundButton{
        
        let view = IconTitleRoundButton()
        view.title = title
        view.icon = icon
        view.iconColor = iconColor
        return view
        
    }
    
    class func iconTitleButton(iconTitleModel:IconTitleModel)->IconTitleRoundButton{
        
        let view = IconTitleRoundButton()
        view.title = iconTitleModel.title
        view.icon = iconTitleModel.icon
        view.vcName = iconTitleModel.vcName
      
        if iconTitleModel.iconColor == "green"
        {
            view.iconColor = AppColor_Green
        }
        else if iconTitleModel.iconColor == "orange"
        {
            view.iconColor = AppColor_Orange
        }
        else if iconTitleModel.iconColor == "blue"
        {
            view.iconColor = AppColor_Blue
        }
        
        return view
        
    }
    
    static let btnWidth = 48
    static let btnHeight = 80
    
}
