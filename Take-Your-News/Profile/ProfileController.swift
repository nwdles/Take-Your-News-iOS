//
//  ProfileController.swift
//  Take-Your-News
//
//  Created by Anastasiya on 18/05/2020.
//  Copyright © 2020 Anastasiya. All rights reserved.
//

import UIKit

class ProfileController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var loginLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.text = UserDefaults.standard.string(forKey: "name")
        
        loginLabel.text = "@" + (UserDefaults.standard.string(forKey: "login") ?? "")
    }
    


}
