//
//  RowEditView.swift
//  OA
//
//  Created by 洪继伟 on 2021/11/29.
//

import UIKit

class RowSelectView: RowBaseView{

    lazy var pickView: UIPickerView = {
        let temp = UIPickerView()
        temp.delegate = self
        temp.dataSource = self
        
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
        temp.text = "请选择"
        return temp
    }()
    
    lazy var arrowView: UIImageView = {

        let temp = UIImageView(image: UIImage(named: "icon_arrow_right"))
        temp.tintColor = UIColor.gray
        return temp
    }()
    
    
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
    
    @objc func actionSheet(){
        let vc = self.getFirstViewController()
        vc?.view.endEditing(false)
        
        let actionSheetVC = ActionSheetController(title: self.title ?? "", contentView: pickView)
        actionSheetVC.delegate = self
        vc?.present(actionSheetVC, animated: true, completion: nil)
    }
    
    
    var dataSource : [SelectListItem] = [] {
        didSet{
            pickView.reloadAllComponents()
            layoutIfNeeded()
        }
    }
    
    private var selectIndex = -1
    var selectItem:SelectListItem?{
        didSet{
            guard let _selectItem = selectItem else {
                return
            }
            
            contentView.text = _selectItem.text
        }
    }
    
    
    ///验证
    override func valid() -> Bool{
        
        if !isRequire {
            return true
        }
        
        return selectItem != nil
     }
     

    ///取值
    func getValue() -> SelectListItem? {
        return selectItem
     }
    
    
    class func rowSelectView(_ title:String, dataSource:[SelectListItem], showBorder:Bool?=false, isRequire:Bool?=false)->RowSelectView{
        let view = RowSelectView()
        
        view.arrowView.snp.updateConstraints { make in
            make.width.equalTo(20)
        }
        view.title = title
        view.dataSource = dataSource
        view.showBorder = showBorder ?? false
        view.isRequire = isRequire ?? false
        return view;
    }

}

extension RowSelectView: ActionSheetDelegate {
    func ActionSheetConfirm() {
       let index = self.pickView.selectedRow(inComponent: 0)
        self.contentView.text = self.dataSource[index].text
        self.selectIndex = index
        self.selectItem = self.dataSource[index]
    }
}


extension RowSelectView: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataSource.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dataSource[row].text
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40
    }
}
