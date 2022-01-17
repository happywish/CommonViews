//
//  RowTextFieldView.swift
//  OA
//
//  Created by 洪继伟 on 2021/11/29.
//

import UIKit


protocol RowBaseViewProtocol {
    func valid()->Bool
}

class RowBaseView: UIView ,RowBaseViewProtocol{
    
    static let RowHeight = 48
    
    lazy var titleView: UILabel = {
        let temp = UILabel()
        temp.font = UIFont.systemFont(ofSize: 15)
        temp.textColor = TEXT_COLOR_BLACK_87
        return temp
    }()
    
    lazy var borderBottom: UIView = {
        let temp = UIView()
        temp.backgroundColor = AppColor_Border
        return temp
    }()
    
    lazy var requiredLabel: UILabel = {
        let temp = UILabel()
        temp.font = UIFont.systemFont(ofSize: 12)
        temp.textColor = AppColor_Red
        temp.text = "✱"
        return temp
    }()
    
    var showBorder:Bool = false {
        didSet{
            borderBottom.isHidden = !showBorder
        }
    }
    
    var title :String="" {
        didSet{
            titleView.text = title
        }
    }
    
    var isRequire:Bool = false {
        didSet{
          
            if isRequire{
                requiredLabel.snp.updateConstraints { make in
                    make.width.equalTo(16)
                }
            }else{
                requiredLabel.snp.updateConstraints { make in
                    make.width.equalTo(0.1)
                }
            }
            self.layoutIfNeeded()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.white
        
        addSubview(requiredLabel)
        requiredLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
            make.width.equalTo(0.1)
        }
        
        addSubview(titleView)
        titleView.snp.makeConstraints { make in
            make.left.equalTo(requiredLabel.snp.right)
            make.centerY.equalToSuperview()
        }
        
        addSubview(borderBottom)
        borderBottom.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.width.equalToSuperview()
            make.height.equalTo(1)
            make.bottom.equalToSuperview()
            
            borderBottom.isHidden=true
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    func valid() -> Bool{
        return true
    }

    
    class func rowBaseView(_ title:String, showBorder:Bool?=false,isRequire:Bool?=false)->RowBaseView{
        let view = RowBaseView()
        
        view.title = title
        view.showBorder = showBorder ?? false
        view.isRequire = isRequire ?? false
        return view;
    }
    
}
