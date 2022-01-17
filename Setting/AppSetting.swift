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


let AliyunOSS_Endpoint = "https://oss-cn-hangzhou.aliyuncs.com"
//let AliyunOSS_AccessKeyId = "LTAI5tLd8qhhaNhKuB2wHS4x"
//let AliyunOSS_AccessKeySecret = "H4THvqQ0Hj08MGxqXHTEDjzuqZk5gr"
//let AliyunOSS_DefaultBucketName = "jkoav1"
//let AliyunOSS_PreviewBaseUrl = "https://jkoav1.oss-cn-hangzhou.aliyuncs.com"


let AliyunOSS_AccessKeyId = "LTAI5tDTojghLc68jwhSGTog"
let AliyunOSS_AccessKeySecret = "z37XdQBr4YywYP5vWwEXDPIagkc9Co"
let AliyunOSS_DefaultBucketName = "dosomething-001"
let AliyunOSS_PreviewBaseUrl = "https://dosomething-001.oss-cn-hangzhou.aliyuncs.com"
