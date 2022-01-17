//
//  CardButton.swift
//  OA
//
//  Created by 洪继伟 on 2021/11/26.
//

import UIKit

class CardButton: UIButton {

    lazy var titleView: UILabel = {
        let temp = UILabel()
        temp.font=UIFont.systemFont(ofSize: 18)
        temp.textColor = UIColor.white
        return temp
    }()
    
    lazy var subTitleView: UILabel = {
        let temp = UILabel()
        temp.font=UIFont.systemFont(ofSize: 13)
        temp.textColor = UIColor.white
        return temp
    }()
    
    lazy var iconView: UIImageView = {
        let temp = UIImageView()
        return temp
    }()
    
    var title:String=""{
        didSet{
            titleView.text = title
        }
    }
    
    var subTitle:String=""{
        didSet{
            subTitleView.text = subTitle
        }
    }
    
    var icon:String=""{
        didSet{
            iconView.image=UIImage(named: icon)
        }
    }
    
    var bgColor:UIColor=UIColor.gray{
        didSet{
            backgroundColor=bgColor
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        backgroundColor=UIColor.white
        
        addSubview(titleView)
        titleView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(20)
        }
        
        addSubview(subTitleView)
        subTitleView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.top.equalTo(titleView.snp.bottom).offset(5)
        }
        
        addSubview(iconView)
        iconView.snp.makeConstraints { make in
            make.width.height.equalTo(32)
            make.top.equalTo(titleView)
            make.right.equalToSuperview().offset(-20)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    class func cardButton(title:String,subTitle:String,icon:String,bgColor:UIColor)->CardButton{
        let view = CardButton()
        view.title = title
        view.subTitle = subTitle
        view.icon = icon
        view.backgroundColor = bgColor
        return view
    }

}
