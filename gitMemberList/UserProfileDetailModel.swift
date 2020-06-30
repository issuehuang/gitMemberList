//
//  UserProfileDetailModel.swift
//  gitMemberList
//
//  Created by APP技術部-黃一修 on 2020/6/30.
//  Copyright © 2020 APP技術部-黃一修. All rights reserved.
//

import Foundation

struct UserProfileDetailModel: Codable {
    
    let avatar_url: String?
    let name: String?
    let bio: String?
    let login: String?
    let site_admin: Bool
    let location: String?
    let blog: String?
}
