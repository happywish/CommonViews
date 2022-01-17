//
//  PlaceholderTextView.swift
//  OA
//  带placeholder的文本域
//  Created by 洪继伟 on 2021/12/24.
//

import UIKit

class PlaceholderTextView: UITextView {

   private lazy var placeholderLabel: UILabel = {
        let temp =  UILabel()
        temp.font = font
        temp.textColor = UIColor.gray
        temp.textAlignment = textAlignment
        temp.text = placeholder
        temp.numberOfLines = 0
        temp.backgroundColor = UIColor.clear
        temp.translatesAutoresizingMaskIntoConstraints = false
        return temp
    }()
    
    @IBInspectable open var placeholder: String = "请输入" {
        didSet {
            placeholderLabel.text = placeholder
        }
    }
    
    open var placeholderFont: UIFont? {
        didSet {
            let font = (placeholderFont != nil) ? placeholderFont : self.font
            placeholderLabel.font = font
        }
    }
    
    override open var font: UIFont! {
        didSet {
            if placeholderFont == nil {
                placeholderLabel.font = font
            }
        }
    }
    
    override open var textAlignment: NSTextAlignment {
        didSet {
            placeholderLabel.textAlignment = textAlignment
        }
    }
    
    override open var text: String! {
        didSet {
            textDidChange()
        }
    }
    
    override open var attributedText: NSAttributedString! {
        didSet {
            textDidChange()
        }
    }
    
    
    override public init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    
    private func commonInit() {
        
        for subview in self.subviews {
     
            if String(describing: type(of: subview)) == "_UITextContainerView" {
                subview.insertSubview(placeholderLabel, at: 0)
                
                placeholderLabel.snp.makeConstraints { make in
                    make.left.equalToSuperview().offset(textContainerInset.left)
                    make.top.equalToSuperview().offset(textContainerInset.top)
                }
            }
        }
        
        #if swift(>=4.2)
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange),  name: UITextView.textDidChangeNotification, object: self)
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange),  name: UITextView.textDidBeginEditingNotification, object: self)
        NotificationCenter.default.addObserver(self, selector: #selector(textEndEditing),  name: UITextView.textDidEndEditingNotification, object: self)
        #else
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange),  name: NSNotification.Name.UITextView.textDidChangeNotification, object: self)
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange),  name: NSNotification.Name.UITextView.textDidBeginEditingNotification, object: self)
        NotificationCenter.default.addObserver(self, selector: #selector(textEndEditing),  name: NSNotification.Name.UITextView.textDidEndEditingNotification, object: self)
        #endif
        
    }
    
    @objc private func textEndEditing() {
        placeholderLabel.isHidden = !text.isEmpty
    }
    @objc private func textDidChange() {
        placeholderLabel.isHidden = true
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        placeholderLabel.snp.updateConstraints { make in
            make.left.equalToSuperview().offset(textContainerInset.left)
            make.top.equalToSuperview().offset(textContainerInset.top)
        }
    }
    
    deinit {
      #if swift(>=4.2)
        NotificationCenter.default.removeObserver(self, name: UITextView.textDidChangeNotification, object: self)
        NotificationCenter.default.removeObserver(self, name: UITextView.textDidBeginEditingNotification, object: self)
        NotificationCenter.default.removeObserver(self, name: UITextView.textDidEndEditingNotification, object: self)
      #else
        NotificationCenter.default.removeObserver(self, name: UITextView.NSNotification.Name.textDidChangeNotification, object: self)
        NotificationCenter.default.removeObserver(self, name: UITextView.NSNotification.Name.textDidBeginEditingNotification, object: self)
        NotificationCenter.default.removeObserver(self, name: UITextView.NSNotification.Name.textDidEndEditingNotification, object: self)
      #endif
    }
}
