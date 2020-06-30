//
//  UserProfileListModel.swift
//  gitMemberList
//
//  Created by APP技術部-黃一修 on 2020/6/30.
//  Copyright © 2020 APP技術部-黃一修. All rights reserved.
//

import Foundation

struct UserProfileListModel: Codable {
    let id: Int
    let login: String
    let avatar_url: String
    let site_admin: Bool
    let url: String
}
