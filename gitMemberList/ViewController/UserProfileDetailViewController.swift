//
//  UserProfileDetailViewController.swift
//  gitMemberList
//
//  Created by APP技術部-黃一修 on 2020/6/30.
//  Copyright © 2020 APP技術部-黃一修. All rights reserved.
//

import UIKit
import JGProgressHUD
class UserProfileDetailViewController: UIViewController {

    
    @IBOutlet weak var avatorImage: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var loginStrLabel: UILabel!
    
    @IBOutlet weak var locationLabel: UILabel!
    
    
    @IBOutlet weak var blogLabel: UILabel!
    
    lazy var viewModel: UserProfileDetailViewModel = {
        return UserProfileDetailViewModel()
    }()
    var loginStr:String? = ""
    let hud = JGProgressHUD(style: .dark)

    @IBAction func pressDismissBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewModel()
        initView()
    }
    func initView(){
        self.avatorImage.layer.cornerRadius = self.avatorImage.frame.size.width/2
    }

    func initViewModel(){
        viewModel.reloadViewClosure = { [weak self]() in
            DispatchQueue.main.async {
                if let data = self?.viewModel.userDetail{
                    self?.nameLabel.text = data.name
                    self?.loginStrLabel.text = data.login
                    self?.blogLabel.text = data.blog
                    if  let url = URL(string: data.avatar_url ?? "") {
                         let data = try! Data(contentsOf: url )
                        self?.avatorImage.image = UIImage(data: data)
                    }
                }
            }
            
            
        }
        viewModel.updateLoadingStatus = { [weak self] () in
               DispatchQueue.main.async {
                            let isLoading = self?.viewModel.isLoading ?? false
                                      if isLoading {
                                       self?.hud.show(in: self?.view ?? UIView())
                   }
                                      else{
                                       self?.hud.dismiss()
                   }
                      }
                  }
        viewModel.initFetch(with: self.loginStr ?? "")
    }

}
