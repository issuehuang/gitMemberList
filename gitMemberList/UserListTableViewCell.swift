//
//  UserListTableViewCell.swift
//  gitMemberList
//
//  Created by APP技術部-黃一修 on 2020/6/30.
//  Copyright © 2020 APP技術部-黃一修. All rights reserved.
//

import UIKit

class UserListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userAvator: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    var userListCellModel:UserProfileListModel?{
        didSet{
            if  let url = URL(string: userListCellModel?.avatar_url ?? "") {
                 let data = try! Data(contentsOf: url )
                userAvator.image = UIImage(data: data)
            }
            userNameLabel.text = userListCellModel?.login

        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.userAvator.layer.cornerRadius = 25
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
