//
//  ImageButton.swift
//  OA
//  图标-标题按钮
//  Created by 洪继伟 on 2021/12/1.
//

import UIKit

class IconTitleSmallButton: UIButton {

    lazy var customerTitleLabel: UILabel = {
        let temp = UILabel()
        temp.font = UIFont.systemFont(ofSize: 13)
        temp.textColor = TEXT_COLOR_BLACK_68
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
        
        addSubview(iconView)
        addSubview(customerTitleLabel)
       
        
        iconView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(2)
            make.width.height.equalTo(20)
        }
        
        customerTitleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(iconView.snp.bottom).offset(2)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    class func iconTitleButton(title:String,icon:String)->IconTitleSmallButton{
        
        let view = IconTitleSmallButton()
        view.title = title
        view.icon = icon
        return view
        
    }
    
    class func iconTitleButton(iconTitleModel:IconTitleModel)->IconTitleSmallButton{
        
        let view = IconTitleSmallButton()
        view.title = iconTitleModel.title
        view.icon = iconTitleModel.icon
        view.vcName = iconTitleModel.vcName
      
        return view
        
    }
    
    static let BtnWidth:CGFloat = 36
    static let BtnHeight:CGFloat = 44
}
