//
//  UserListViewController.swift
//  gitMemberList
//
//  Created by APP技術部-黃一修 on 2020/6/30.
//  Copyright © 2020 APP技術部-黃一修. All rights reserved.
//

import UIKit
import JGProgressHUD
class UserListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    lazy var viewModel: UserListViewModel = {
        return UserListViewModel()
    }()
    let hud = JGProgressHUD(style: .dark)
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewModel()
        initView()
    }
    func initView(){
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .none
        let nib = UINib(nibName: "UserListTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "UserListTableViewCell")
    }
    
    func initViewModel(){
        
        viewModel.presenVCwithContent = { [weak self] content in
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "UserProfileDetailViewController") as! UserProfileDetailViewController
            //vc.modalPresentationStyle = .popover
            vc.loginStr = content
            self?.present(vc, animated: true, completion: nil)
            
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
        viewModel.reloadTableViewClosure = { [weak self] () in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        viewModel.initFetch()
    }
    
    
}
extension UserListViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserListTableViewCell", for: indexPath) as? UserListTableViewCell else{
            fatalError()
        }
        let user =  viewModel.getUser(at: indexPath)
        cell.userListCellModel = user
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.getUserLoginStr(at: indexPath)
    }
}
