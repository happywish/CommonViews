//
//  RadioButtonGroupView.swift
//  OA
//
//  Created by 洪继伟 on 2021/12/27.
//

import UIKit

class RadioButtonGroupView: UIView {

    private var radios : [RadioButton] = []
    
    var titles:[String]=[]{
        didSet{
            self.removeAllSubViews()
            radios = []
            
            let btnWidth = (App_Screen_Width-24)/4
            var i = 0
            for item in titles{
                let btn = RadioButton()
                btn.setTitle(item, for: UIControl.State.normal)
                btn.addTarget(self, action: #selector(self.click(btn:)), for: UIControl.Event.touchUpInside)
                self.addSubview(btn)
                radios.append(btn)
                
                btn.isSelected = item == defaultSelectItem
                
                btn.snp.makeConstraints { make in
                    make.left.equalToSuperview().offset(20 + i*Int(btnWidth))
                    make.top.equalToSuperview().offset(6)
                    make.height.equalTo(RadioButton.imageHeight)
                    make.width.equalTo(btnWidth)
                }
                
                i+=1
            }
            layoutIfNeeded()
        }
    }
    
    var isMutiSelect = true
    var defaultSelectItem:String?{
        didSet{
            for item in radios {
                if item.titleLabel?.text == defaultSelectItem
                {
                    item.isSelected = true
                }
            }
        }
    }

    @objc func click(btn:RadioButton){
        for item in radios {
            item.isSelected = false
        }
        
        btn.isSelected = !btn.isSelected
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
