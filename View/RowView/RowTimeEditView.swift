//
//  RowEditView.swift
//  OA
//
//  Created by 洪继伟 on 2021/11/29.
//

import UIKit

class RowTimeEditView: RowBaseView {

    lazy var timePicker: UIDatePicker = {
        let temp = UIDatePicker()
        if #available(iOS 13.4, *) {
            temp.preferredDatePickerStyle = UIDatePickerStyle.compact
        }
        
        temp.datePickerMode = UIDatePicker.Mode.dateAndTime
        temp.locale = Locale(identifier: "zh-CN")
       
    
        var calender = Calendar.current
        calender.locale = Locale(identifier: "zh-CN")
        
        temp.calendar = calender
        temp.timeZone = TimeZone.current
        temp.minuteInterval = 10
        return temp
    }()
    
    
    
    lazy var btn: UIButton = {
        let temp = UIButton(type: UIButton.ButtonType.custom)
        temp.addTarget(self, action: #selector(self.actionSheet), for: UIControl.Event.touchUpInside)
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
    
    var content :String? {
        didSet{
            contentView.text = "未设置"
            if let _content = content {
                contentView.text = _content
            }
        }
    }
    

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        if #available(iOS 13.4, *) {
            addSubview(timePicker)
            timePicker.snp.makeConstraints { make in
                make.right.equalToSuperview()
                make.centerY.equalToSuperview()
                make.width.equalTo(282)
                make.height.equalTo(32)
            }
        }
        else{
            
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
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func actionSheet(){
        let vc = self.getFirstViewController()
        vc?.view.endEditing(false)
        
        let actionSheetVC = ActionSheetController(title: self.title ?? "", contentView: timePicker)
        actionSheetVC.delegate = self
        vc?.present(actionSheetVC, animated: true, completion: nil)
    }
    
    
    func getDate() ->Date? {
 
        if #available(iOS 13.4, *) {
            return timePicker.date
        }
    
        if contentView.text == "请选择"
        {
            return nil
        }
        
        return timePicker.date
    }
    
    
    
    ///验证
    override func valid() -> Bool{
        
        if !isRequire {
            return true
        }
        
        if #available(iOS 13.4, *) {
            return  true
        }
    
        if contentView.text == "请选择"
        {
            return false
        }
        
        return true
     }
     
    ///取值
    func getValue() -> String {
         
         if #available(iOS 13.4, *) {
             return timePicker.date.ToString(formatString: "yyyy-MM-dd HH:mm")
         }
     
         if contentView.text == nil || contentView.text == "请选择"
         {
             return ""
         }
         
         return contentView.text!
     }
    
    
    
    class func rowTimeEditView(_ title:String, date:Date, showBorder:Bool?=false, isRequire:Bool?=false)->RowTimeEditView{
        let view = RowTimeEditView()
        
        view.arrowView.snp.updateConstraints { make in
            make.width.equalTo(20)
        }
        view.title = title
        
        let formater = DateFormatter()
        formater.setLocalizedDateFormatFromTemplate("yyyy-MM-dd HH:mm")
        view.content = formater.string(from: date)
        
        view.timePicker.date = date
        view.showBorder = showBorder ?? false
        view.isRequire = isRequire ?? false
        
        return view;
    }

}

extension RowTimeEditView: ActionSheetDelegate {
    func ActionSheetConfirm() {
        
        let formater = DateFormatter()
        formater.setLocalizedDateFormatFromTemplate("yyyy-MM-dd HH:mm")
        self.content = formater.string(from: self.timePicker.date)
        
    }
}
