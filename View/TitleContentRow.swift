//
//  TitleContentRow.swift
//  OA
//
//  Created by 洪继伟 on 2021/12/3.
//

import UIKit

class TitleContentRow: UIView {

    lazy var titleLabel: UILabel = {
        let temp = UILabel()
        temp.font = UIFont.systemFont(ofSize: 15)
        temp.textColor = TEXT_COLOR_BLACK_68
        return temp
    }()
    
    lazy var contentLabel: UILabel = {
        let temp = UILabel()
        temp.font = UIFont.systemFont(ofSize: 15)
        temp.textColor = TEXT_COLOR_BLACK_87
        temp.numberOfLines = 0
        return temp
    }()
    
    var title:String? {
        didSet{
            titleLabel.text = title
        }
    }
    
    var content:String? {
        didSet{
            contentLabel.text = content
        }
    }
    
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        addSubview(titleLabel)
        addSubview(contentLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(App_Space_Width)
            make.width.equalTo(80)
        }
//        titleLabel.backgroundColor = UIColor.random
//        contentLabel.backgroundColor = UIColor.random
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.top)
            make.left.equalTo(titleLabel.snp.right).offset(5)
            make.width.equalTo(App_Screen_Width - 80.0 - 2.0*App_Space_Width  - 5.0)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    class func titleContentRow(title:String,content:String?)->TitleContentRow{
        
        let view = TitleContentRow()
        view.title = title
        view.content = content
        return view
        
    }
    
    func getHeight()->Int{
        let labelSize = contentLabel.sizeThatFits(CGSize(width: (App_Screen_Width - 80.0 - 2.0*App_Space_Width  - 5.0), height: CGFloat(MAXFLOAT)))
        let height = ceil(labelSize.height)

        if height>20.0{
            return Int(height)+10
        }
        
        return 40
    }

    override func layoutSubviews() {
        
    }
}
