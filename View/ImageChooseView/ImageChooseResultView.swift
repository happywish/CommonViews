//
//  ImageChooseView.swift
//  OA
//
//  Created by 洪继伟 on 2021/12/20.
//

import UIKit
import ZYImagePickerAndBrower

class ImageChooseResultView: UIView {
    
    let split:CGFloat = 16
    let imageWidth:CGFloat = 60
    var maxImageCount = 9
    var isEditable = true {
        didSet{
            if !isEditable {
                chooseOrCameraButton.removeFromSuperview()
            }
        }
    }

    var Images:[OssImageModel] = []{
        didSet{
            self.removeAllSubViews()
            
            var i = 0
            var max_y:CGFloat = split
            var max_x:CGFloat = split
            
            //显示图片
            for image in Images {
                let btn = ImageChoosedButton()
                btn.delegate = self
                btn.tag = i
                btn.isEditable = isEditable
                btn.setImage(image)
                btn.width = imageWidth
                btn.height = imageWidth
                
                if (max_x + imageWidth) > App_Screen_Width {
                    max_x = split
                    max_y = max_y + imageWidth + split
                }
                
                btn.x = max_x
                btn.y = max_y
                self.addSubview(btn)
                
                max_x = btn.x + imageWidth + split
                i = i + 1
            }
            
            //显示按钮
            if Images.count<maxImageCount && isEditable{
                
                if (max_x + imageWidth) > App_Screen_Width {
                    max_x = split
                    max_y = max_y + imageWidth + split
                }
                
                chooseOrCameraButton.x =  max_x
                chooseOrCameraButton.y =  max_y
                
                self.addSubview(chooseOrCameraButton)
            }
            
            max_y = max_y + imageWidth + split
            
            //更新约束
            self.snp.updateConstraints { make in
                make.height.equalTo(max_y)
            }
            self.layoutIfNeeded()
        }
    }
    
    //选择图片或相机按钮
    lazy var chooseOrCameraButton: UIButton = {
        let temp = UIButton(type: UIButton.ButtonType.custom)
        temp.setImage(UIImage(named: "sharemore_video"), for: UIControl.State.normal)
        temp.size = CGSize(width: imageWidth, height: imageWidth)
        temp.addTarget(self, action: #selector(self.chooseOrCameraButtonDidClick), for: UIControl.Event.touchUpInside)
        temp.layer.cornerRadius = 10
        temp.layer.masksToBounds = true
        temp.layer.borderWidth = 1
        temp.layer.borderColor = AppColor_Border.cgColor
        return temp
    }()
    
//    //相册选择器
//    lazy var imagePicker: ZYPhotoNavigationViewController = {
//        let temp = ZYPhotoNavigationViewController(photoAlbumDelegate: self, photoAlbumType: .selectPhoto)
//        temp.modalPresentationStyle = UIModalPresentationStyle.fullScreen
//        temp.maxSelectCount = maxImageCount  //最大可选择张数
//        return temp
//    }()
    
    //相机控制器
    lazy var cameraPicker: UIImagePickerController = {
        let temp = UIImagePickerController()
        temp.delegate = self
        temp.sourceType = UIImagePickerController.SourceType.camera
        temp.modalPresentationStyle = UIModalPresentationStyle.custom
        temp.view.backgroundColor = UIColor.white
        temp.navigationBar.setBackgroundImage(UIImage(named: "daohanglanbeijing"), for: UIBarMetrics.default)
        temp.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
     
        return temp
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        self.addSubview(chooseOrCameraButton)
        chooseOrCameraButton.x = split
        chooseOrCameraButton.y = split

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: todo  ==注释==
    func getImage() -> [OssImageModel] {
        return self.Images
    }
    
//    func getImageSrcs() -> [String] {
//        return []
//    }
    
    ///拍照或选择图片按钮被点击
    @objc func chooseOrCameraButtonDidClick(){
        
        //获取view 所在的controller
        guard let controller = self.getFirstViewController() else {
            return
        }
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        
        let btnChoose = UIAlertAction(title: "选择图片", style: UIAlertAction.Style.default) { _ in
           if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary)
            {
               let imagePicker = ZYPhotoNavigationViewController(photoAlbumDelegate: self, photoAlbumType: .selectPhoto)
               imagePicker.modalPresentationStyle = UIModalPresentationStyle.fullScreen
               imagePicker.maxSelectCount = self.maxImageCount -  self.Images.count
               
               controller.present(imagePicker, animated: true, completion: nil)
            }
            else{
                let alertVc = UIAlertController.alert(title: "提示信息", message: "请在iPhone的“设置-隐私”选项中，允许访问你的相册。")
                controller.present(alertVc, animated: true, completion: nil)
            }
        }
        
        let btnCamera = UIAlertAction(title: "拍照", style: UIAlertAction.Style.default) { _ in
           
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera)
             {
                controller.present(self.cameraPicker, animated: true, completion: nil)
             }
             else{
                 let alertVc = UIAlertController.alert(title: "提示信息", message: "请在iPhone的“设置-隐私”选项中，允许访问你的相机。")
                 controller.present(alertVc, animated: true, completion: nil)
             }
        }
        
        let btnCancel = UIAlertAction(title: "取消", style: UIAlertAction.Style.cancel, handler: nil)
        alert.addAction(btnChoose)
        alert.addAction(btnCamera)
        alert.addAction(btnCancel)
        
        controller.present(alert, animated: true, completion: nil)
    }
    
}

extension ImageChooseResultView: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        self.cameraPicker.dismiss(animated: true)
        
        let uploadImage = OssImageModel(image: image)
        
        self.Images.append(uploadImage)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.cameraPicker.dismiss(animated: true)
    }
}

extension ImageChooseResultView: ZYPhotoAlbumProtocol {
    
    func photoAlbum(selectPhotos: [ZYPhotoModel]) {
       //选择的照片之后去layoutView显示
       let imageArray = selectPhotos.map { (model) -> OssImageModel in
           return OssImageModel(image: model.originImage!)
       }
    
        self.Images.append(contentsOf: imageArray)
    }
}

extension ImageChooseResultView: ImageChoosedButtonDelegate {
    func BrowerPhoto(index: Int) {
      let vc =  self.getFirstViewController()
        
        let photoPreviewVC = ZYPhotoPreviewDeleteViewController()
        photoPreviewVC.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        
        var  imageModels:[ZYPhotoModel] = []
        for image in self.Images {
            imageModels.append(ZYPhotoModel(thumbnailImage: nil, originImage: image.image, imageURL: ""))
        }
        
        photoPreviewVC.previewPhotoArray = imageModels //传入预览源，为ZYPhotoModel数组，支持缩略图，原图和网络图
        photoPreviewVC.currentIndex = index                    //当前展示第几张
        photoPreviewVC.isAllowDelete = false
        vc?.navigationController?.present(photoPreviewVC, animated: true)
        

//        vc?.navigationController?.present(photoBrowerVC, animated: true)
    }
    
    
    func DeleteBtnDidClick(index: Int) {
        self.Images.remove(at: index)
    }
    
}
