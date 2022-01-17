//
//  SelectListItem.swift
//  OA
//
//  Created by 洪继伟 on 2021/12/21.
//

import UIKit

class SelectListItem: NSObject {
    var text:String = ""
    var value:Any = 0
    
    init(text:String,value:Any) {
        self.text = text
        self.value = value
    }

}
