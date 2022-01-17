//
//  UploadImage.swift
//  OA
//
//  Created by 洪继伟 on 2022/1/8.
//

import UIKit

class OssImageModel: NSObject {
   
    override init(){
        super.init()
    }
    
    init(image:UIImage){
        super.init()
        self.image = image
    }
    
    var isUpload = false
    var image:UIImage?
    
    //oss
    var fileName:String=""
    var ossKey:String=""
    var versionId:String=""
    
    //id
    var id:Int = 0
    var isImg = true
    var url:String?
    
    // 是否加密
    var isSecret:Bool = false
    var dataMapId:Int = 1
    
}
