//
//  UserListViewModel.swift
//  gitMemberList
//
//  Created by APP技術部-黃一修 on 2020/6/30.
//  Copyright © 2020 APP技術部-黃一修. All rights reserved.
//

import Foundation
class UserListViewModel {
    
    var reloadTableViewClosure: (()->())?
    var showAlertClosure: (()->())?
    var updateLoadingStatus: (()->())?
    var presenVCwithContent:((_ content:String)->())?
    private var tableViewDatas:[UserProfileListModel] = [UserProfileListModel](){
        didSet{
            self.reloadTableViewClosure?()
        }
        
    }
    var isLoading: Bool = false {
        didSet {
            self.updateLoadingStatus?()
        }
    }
    
    var numberOfRows:Int{
        return tableViewDatas.count
    }
    
    var alertMessage: String? {
        didSet {
            self.showAlertClosure?()
        }
    }
    var loginStr:String?{
        didSet{
            self.presenVCwithContent?(loginStr ?? "")
        }
    }
    
    func initFetch(){
        self.isLoading  = true
        ConnectionTools.share.getUserList { (success, error, userList) in
            if let error = error {
                self.alertMessage = "Oops! someting Wrong!\(error.localizedDescription)"
            }else
            {
                self.isLoading = false
                self.tableViewDatas = userList ?? [UserProfileListModel]()
            }
        }
    }
    func getUser(at indexPath:IndexPath)->UserProfileListModel{
        return tableViewDatas[indexPath.row]
    }
    
    func getUserLoginStr(at indexPath:IndexPath){
        self.loginStr = tableViewDatas[indexPath.row].login
    }
}
