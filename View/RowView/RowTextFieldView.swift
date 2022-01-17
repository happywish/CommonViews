//
//  RowTextFieldView.swift
//  OA
//
//  Created by 洪继伟 on 2021/11/29.
//

import UIKit

class RowTextFieldView: RowBaseView {
    
    lazy var textFeild: UITextField = {
        let temp = UITextField()
        temp.font = UIFont.systemFont(ofSize: 15)
        temp.textColor = TEXT_COLOR_BLACK_54
        temp.textAlignment = NSTextAlignment.right
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 32))
        temp.rightViewMode = .always
        return temp
    }()
    
    lazy var spaceView: UIView = {
        let temp = UIView()
        return temp
    }()
    
    var content :String? {
        
        get{
            return textFeild.text;
        }
        set{
            textFeild.text = newValue
        }
    }
    
    var placeholder :String = "请输入" {
        didSet{
            textFeild.placeholder = placeholder
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(textFeild)
        
        textFeild.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.centerY.equalToSuperview()
            make.left.equalTo(self.snp.centerX)
            make.height.equalTo(32)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    ///验证
    override func valid() -> Bool{
        
        if !isRequire {
            return true
        }
        
        if let _text = textFeild.text {
           
            if _text.count > 0 {
                return true
            }
            
        }
        
        return false
     }
     
    ///取值
    func getValue() -> String {
         return textFeild.text ?? ""
     }
    
    class func rowTextFieldView(_ title:String, content:String?=nil, placeholder:String?=nil, showBorder:Bool?=false, isRequire:Bool?=false)->RowTextFieldView{
        let view = RowTextFieldView()
        
        view.title = title
        view.showBorder = showBorder ?? false
        view.isRequire = isRequire ?? false
        
        if let _content = content {
            view.content = _content
        }
        
        if let _placeholder = placeholder {
            view.placeholder = _placeholder
        }
        
        
        return view;
    }

}
