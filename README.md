### ImageChooseView


- 效果
![img]("2022-01-17162312")


- 用法
```swift

    //图片
    lazy var pictureTitleView: RowBaseView = {
        let temp = RowBaseView.rowBaseView("图片")
        return temp
    }()

    //图片选择块
    lazy var imageChooseResultView: ImageChooseResultView = {
        let temp = ImageChooseResultView()
        temp.maxImageCount = 9
        return temp
    }()


```