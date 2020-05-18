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
    

    @IBAction func logOut(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "basicAuth")
        UserDefaults.standard.removeObject(forKey: "name")
        UserDefaults.standard.removeObject(forKey: "login")

        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "loginViewController") as! LoginViewController
        viewController.modalPresentationStyle = .overFullScreen
        self.definesPresentationContext = false
        present(viewController, animated: true, completion: nil)
        
    }
    
}
