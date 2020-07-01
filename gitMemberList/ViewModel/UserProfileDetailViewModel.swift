//
//  UserProfileDetailViewModel.swift
//  gitMemberList
//
//  Created by APP技術部-黃一修 on 2020/6/30.
//  Copyright © 2020 APP技術部-黃一修. All rights reserved.
//

import Foundation
class UserProfileDetailViewModel {
    var reloadViewClosure: (()->())?
    var showAlertClosure: (()->())?
    var updateLoadingStatus: (()->())?
    var userDetail:UserProfileDetailModel?{
        didSet{
            self.reloadViewClosure?()
        }
    }
    
    
    var isLoading: Bool = false {
        didSet {
            self.updateLoadingStatus?()
        }
    }
    
    var alertMessage: String? {
        didSet {
            self.showAlertClosure?()
        }
    }
    func initFetch(with loginStr:String){
        self.isLoading = true
        ConnectionTools.share.getUserDetail(loginStr: loginStr) { (isSuccess, error, data) in
            if let error = error {
                self.alertMessage = "Oops! someting Wrong!\(error.localizedDescription)"
            }else
            {
                 self.isLoading = false
                self.userDetail = data
            }
        }
    }
}
