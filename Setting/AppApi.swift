//
//  AppApi.swift
//  OA
//
//  Created by 洪继伟 on 2021/11/23.
//

import Foundation

let API_BaseUrl = "http://117.148.147.208:8087"
//let API_BaseUrl = "http://5r6jem.natappfree.cc"


//授权及密码修改
let API_Auth = API_BaseUrl+"/api/Auth/GetToken"
let API_ConfirmPwd = API_BaseUrl+"/api/User/ConfirmPwd"
let API_EditPwd = API_BaseUrl+"/api/User/EditPwd"


//MARK: 通知模块  ==注释==
//获取消息类型分页列表
let API_Notice_GetClassList = API_BaseUrl + "/api/Notice/GetClassList"
let API_Notice_GetPagerList = API_BaseUrl + "/api/Notice/GetPagerList"
let API_Notice_GetById = API_BaseUrl + "/api/Notice/GetById"


//通讯录列表
let API_Contact_ContactList = API_BaseUrl + "/api/MailList/GetStaffListByTenementId"
let API_Contact_SearchUser = API_BaseUrl + "/api/MailList/SearchUser"

//用户详情
let API_User_GetUserInfo = API_BaseUrl + "/api/User/GetUserInfo"



//项目
let API_Project_Config = API_BaseUrl + "/api/Project/AddInit"
let API_Project_Add = API_BaseUrl + "/api/Project/Add"
let API_Project_StatusScene = API_BaseUrl + "/api/Project/GetListInit"
let API_Project_GetList = API_BaseUrl + "/api/Project/GetList"
let API_Project_Detail = API_BaseUrl + "/api/Project/Detail"

//请求时间，减少加载频率
var Time_Contact_ContactList = ""

var Data_Project_Config:AnyObject?
