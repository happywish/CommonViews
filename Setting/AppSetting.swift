//
//  AppSetting.swift
//  OA
//
//  Created by 洪继伟 on 2021/11/23.
//

import Foundation

//服务器配置
//项目标签
//项目来源

let App_CompanyName =  "浙江金开物联网科技有限公司"
let App_CompanyId =  2

let App_Token_Key = "Token"



//间隙宽度
let App_Space_Width:CGFloat = 12
//屏幕尺寸
let App_Screen_Width:CGFloat = UIScreen.main.bounds.width
let App_Screen_Height:CGFloat = UIScreen.main.bounds.height

//测试token
let App_Test_Token = ""


var App_ProjectStatus = [SelectListItem(text: "预制", value: 0),
                     SelectListItem(text: "待审核", value: 1),
                     SelectListItem(text: "审核中", value: 2),
                     SelectListItem(text: "驳回待审核", value: 3),
                     SelectListItem(text: "已审核", value: 10),
                     SelectListItem(text: "进行中", value: 20),
                     SelectListItem(text: "推迟", value: 30),
                     SelectListItem(text: "已结束", value: 40),
                     SelectListItem(text: "已归档", value: 50)]


let AliyunOSS_Endpoint = ""
//let AliyunOSS_AccessKeyId = ""
//let AliyunOSS_AccessKeySecret = ""
//let AliyunOSS_DefaultBucketName = ""
//let AliyunOSS_PreviewBaseUrl = ""


let AliyunOSS_AccessKeyId = ""
let AliyunOSS_AccessKeySecret = ""
let AliyunOSS_DefaultBucketName = ""
let AliyunOSS_PreviewBaseUrl = ""
