//
//  ViewController.swift
//  gitMemberList
//
//  Created by APP技術部-黃一修 on 2020/6/30.
//  Copyright © 2020 APP技術部-黃一修. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func pressGitListBtn(_ sender: Any) {
        performSegue(withIdentifier: "toUserListSegue", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }


}

