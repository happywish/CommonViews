//
//  RowEditView.swift
//  OA
//
//  Created by 洪继伟 on 2021/11/29.
//

import UIKit

class RowButtonView: RowBaseView {
    
    lazy var btn: UIButton = {
        let temp = UIButton(type: UIButton.ButtonType.custom)
        temp.addTarget(self, action: #selector(self.defaultEvent), for: UIControl.Event.touchUpInside)
        return temp
    }()

    
    lazy var contentView: UILabel = {
        let temp = UILabel()
        temp.font = UIFont.systemFont(ofSize: 15)
        temp.textColor = TEXT_COLOR_BLACK_54
        return temp
    }()
    
    lazy var arrowView: UIImageView = {

        let temp = UIImageView(image: UIImage(named: "icon_arrow_right"))
        temp.tintColor = UIColor.gray
        return temp
    }()
    
    
    var content :String=""{
        didSet{
            contentView.text = content
        }
    }
    var placeholder :String="未设置"
    var contentColor:UIColor=TEXT_COLOR_BLACK_54{
        didSet{
            contentView.textColor = contentColor
        }
    }
    
    override var tag: Int{
        didSet{
            btn.tag = tag
        }
    }
  
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(btn)
        btn.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.centerY.equalToSuperview()
            make.left.equalTo(self.snp.centerX)
            make.height.equalTo(32)
        }
        
        btn.addSubview(arrowView)
        arrowView.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-16)
            make.height.width.equalTo(20)
            make.centerY.equalToSuperview()
        }
        
        btn.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.right.equalTo(arrowView.snp.left).offset(-5)
            make.centerY.equalToSuperview()
        }
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    open func addTarget(_ target: Any?, action: Selector, for controlEvents: UIControl.Event){
        self.btn.addTarget(target, action: action, for: controlEvents)
    }
    
    
    @objc private func defaultEvent(){
        let vc = self.getFirstViewController()
        vc?.view.endEditing(false)
    }
    
    
    ///验证
    override func valid() -> Bool{
        
        if !isRequire {
            return true
        }
        
        if contentView.text != nil && contentView.text!.count > 0 && contentView.text != placeholder {
            return true
        }
        
        return false
     }
     
    ///取值
    func getValue() -> String {
        return contentView.text ?? ""
     }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if content.count>0 {
            contentView.text = content
        }
        else{
            contentView.text = placeholder
        }
    }
    
    class func rowButtonView(_ title:String, content:String? = nil, placeholder:String? = nil, showBorder:Bool?=false, isRequire:Bool?=false , target:Any? = nil, action:Selector? = nil)->RowButtonView{
        let view = RowButtonView()
        
        view.arrowView.snp.updateConstraints { make in
            make.width.equalTo(0)
        }

        view.title = title
        view.showBorder = showBorder ?? false
        view.isRequire = isRequire ?? false
        
        if let _content = content {
            view.content = _content
        }
        
        if let _placeholder = placeholder {
            view.placeholder = _placeholder
        }
        
        if target != nil {
            view.btn.addTarget(target, action: action!, for: UIControl.Event.touchUpInside)
            view.arrowView.snp.updateConstraints { make in
                make.width.equalTo(20)
            }
        }else{
            view.arrowView.snp.updateConstraints { make in
                make.width.equalTo(0)
            }
        }
        
        return view;
    }

}
