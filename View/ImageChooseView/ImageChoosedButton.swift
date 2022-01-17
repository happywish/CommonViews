//
//  ImageChoosedButton.swift
//  OA
//
//  Created by 洪继伟 on 2021/12/21.
//

import UIKit
import AliyunOSSiOS


@objc protocol ImageChoosedButtonDelegate:NSObjectProtocol{
    @objc func DeleteBtnDidClick(index:Int) -> Void
    @objc func BrowerPhoto(index:Int) -> Void
}

class ImageChoosedButton: UIButton {

    var isEditable = true {
        didSet{
            closeBtn.isHidden = !isEditable
            resultLabel.isHidden = !isEditable
        }
    }
    
    lazy var closeBtn: UIButton = {
        let temp = UIButton()
        temp.setImage(UIImage(named: "icon_delete"), for: UIControl.State.normal)
        temp.setBackgroundImage(UIImage.imageWithColor(color: TEXT_COLOR_BLACK_27), for: UIControl.State.normal)
        temp.setBackgroundImage(UIImage.imageWithColor(color: TEXT_COLOR_BLACK_54), for: UIControl.State.highlighted)
        temp.layer.cornerRadius = 9
        temp.layer.masksToBounds = true
        temp.addTarget(self, action: #selector(self.deleteDidClick), for: UIControl.Event.touchUpInside)
     
        temp.imageEdgeInsets = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
        return temp
    }()
    
    lazy var resultLabel: UILabel = {
        let temp = UILabel()
        temp.textColor = UIColor.white
        temp.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        temp.font = UIFont.systemFont(ofSize: 12)
        temp.textAlignment = NSTextAlignment.center
        return temp
    }()
    
    weak var delegate:ImageChoosedButtonDelegate?
    
//    private var content_image:UIImage?
//    override func setImage(_ image: UIImage?, for state: UIControl.State) {
//        super.setImage(image, for: state)
//        content_image = image
//    }
    
    let dateFormatter :DateFormatter = DateFormatter()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(closeBtn)
        self.addSubview(resultLabel)
        
        closeBtn.snp.makeConstraints { make in
            make.top.right.equalToSuperview()
            make.height.width.equalTo(18)
        }
        
        resultLabel.snp.makeConstraints { make in
            make.bottom.width.equalToSuperview()
            make.height.equalTo(20)
        }
        
        self.layer.cornerRadius = 2
        self.layer.masksToBounds = true
        
        self.addTarget(self, action: #selector(self.BrowerPhoto), for: UIControl.Event.touchUpInside)
        
//        fileName = Date().ToString(formatString: "yyyyMMddhhmmssSSS")+"_ios.png"
        osskey = NSUUID().uuidString + "-ios"
//        fileName = osskey + ".png"
//        print(fileName)
    }
    
    
//    override func setImage(_ image: UIImage?, for state: UIControl.State) {
//        fatalError("setImage(_ image: , for state: ) has not been implemented")
//    }
    
    func setImage(_ image: OssImageModel) {

        uploadImageModel = image
        
        if isEditable {
            if !image.isUpload  {
                self.submitImageToOSS(image: image.image!)
            }
            else{
                self.resultLabel.text = "已上传"
            }
        }
       
        
        if image.image != nil {
            super.setImage(image.image, for: UIControl.State.normal)
        }
        
        if image.url != nil {
            super.sd_setImage(with: URL(string: image.url!), for: UIControl.State.normal) { resImage, error, cachType, url in
                if resImage != nil {
                    image.image = resImage
                }
            }
        }
    }

    var uploadImageModel:OssImageModel?{
        didSet{
            if let _uploadImageModel = uploadImageModel{
                _uploadImageModel.fileName = self.osskey + ".png"
                _uploadImageModel.ossKey = self.osskey
            }
        }
    }
    var osskey = ""
//    var fileName = ""
    var isUploadFinish = false
    var isUploadError = false

    //上传图片
    func submitImageToOSS(image: UIImage) -> Void {
        
        isUploadFinish = false
        isUploadError = false
        self.uploadImageModel?.versionId = ""
        let request = OSSPutObjectRequest()
        request.uploadingData = image.pngData()!
        request.bucketName = AliyunOSS_DefaultBucketName
        request.contentType = "application/octet-stream"
//        request.objectKey = "landscape-painting.jpeg"
        request.objectKey = osskey
        request.uploadProgress = { (bytesSent: Int64, totalBytesSent: Int64, totalBytesExpectedToSend: Int64) -> Void in
            print("bytesSent:\(bytesSent),totalBytesSent:\(totalBytesSent),totalBytesExpectedToSend:\(totalBytesExpectedToSend)");
            
            DispatchQueue.main.async {
                let persent = Int(Double(totalBytesSent)/Double(totalBytesExpectedToSend) * 100.0)
                self.resultLabel.text = "\(persent)%"
            }
           
        };
        
        let provider = OSSCustomSignerCredentialProvider.init { (content, error) -> String? in
            
            let tToken = OSSFederationToken()
            tToken.tAccessKey = AliyunOSS_AccessKeyId
            tToken.tSecretKey = AliyunOSS_AccessKeySecret
            
            return OSSUtil.sign(content, with: tToken)
        }
        
        let client = OSSClient.init(endpoint: AliyunOSS_Endpoint, credentialProvider: provider!)
        
        DispatchQueue.global().async { [weak self] in
            
            let task = client.putObject(request)
            task.continue({ (t) -> Any? in
                
                DispatchQueue.main.async {
                    self!.showResult(task: t)
                }
                
            }).waitUntilFinished()
            
        }

    }
    
    
    func showResult(task: OSSTask<AnyObject>?) -> Void {
        if (task?.error != nil) {
            let error: NSError = (task?.error)! as NSError
            print(error)
            self.isUploadError =  true
            self.resultLabel.text = "上传出错"
        }else
        {
            self.isUploadFinish = true
            self.resultLabel.text = "已上传"
            self.uploadImageModel?.isUpload = true
            let result = task?.result
            if let _result = result {
               let r = _result as! OSSResult
                self.uploadImageModel?.ossKey = r.requestId
                self.uploadImageModel?.versionId = r.httpResponseHeaderFields["x-oss-version-id"] as? String ?? ""
            }
          
            print(result)
        }
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   @objc private func deleteDidClick() {
       
       guard let _delegate = delegate else {
           return
       }
  
       _delegate.DeleteBtnDidClick(index: self.tag)

    }
    
    @objc private func BrowerPhoto() {
        
        guard let _delegate = delegate else {
            return
        }
        
        _delegate.BrowerPhoto(index: self.tag)
     }
    
    

    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
}
