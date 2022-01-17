### ImageChooseView

- 效果
![img](2022-01-17162312.gif)

- 用法
  编辑模式
```swift

    //图片选择块
    lazy var imageChooseResultView: ImageChooseResultView = {
        let temp = ImageChooseResultView()
        temp.maxImageCount = 9 
        return temp
    }()

//布局
        imageChooseResultView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.width.equalToSuperview()
            make.top.equalTo(pictureTitleView.snp.bottom).offset(-10)
            make.height.equalTo(100)
        }

```

不可编辑模式
```swift
    //图片选择块
    lazy var imageChooseResultView: ImageChooseResultView = {
        let temp = ImageChooseResultView()
//        temp.maxImageCount = 0
        temp.isEditable = false
        return temp
    }()

//布局
  imageChooseResultView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.width.equalToSuperview()
            make.top.equalTo(pictureTitleView.snp.bottom).offset(-10)
            make.height.equalTo(100)
            
            make.bottom.equalTo(pictrueView.snp.bottom)
        }
        
        let images = fileList.map { item -> OssImageModel in
            let model = OssImageModel()
            
            model.isUpload = true
          
            //oss
            model.fileName = item.fileName ?? ""
            model.ossKey = item.ossKey ?? ""
            model.versionId = item.versionId ?? ""
            
            //id
            model.id = Int(item.id ?? "0") ?? 0
            model.isImg = item.isImg
            model.url = item.url
            
            // 是否加密
            model.isSecret = item.isSecret
            model.dataMapId = item.dataMapId
            
            return model
        }
        imageChooseResultView.Images = images
```