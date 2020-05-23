//
//  PublicationControllerTableViewController.swift
//  Take-Your-News
//
//  Created by Anastasiya on 18/05/2020.
//  Copyright © 2020 Anastasiya. All rights reserved.
//

import UIKit

class PublicationController: UITableViewController {

    var category: Category?
    var publications: [Publication]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            NetworkingService.shared.requestPublication(endpoint: "/categories/\(self.category!.id)", basicAuth: UserDefaults.standard.string(forKey: "basicAuth")) { (result) in
            switch result {
            case .success(let publications):
                    self.publications = publications.data
                    self.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }

        tableView.register(PublicationCell.self, forCellReuseIdentifier: "cellId")

        tableView.tableFooterView = UIView(frame: .zero)
        navigationItem.title = category?.name
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0, green: 0.3285208941, blue: 0.5748849511, alpha: 1)

    }
    

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      

        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! PublicationCell
        let publicationInCategory = publications?[indexPath.row]
        cell.publication = publicationInCategory
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = publications?.count else { return 0}
        return count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let publication = publications?[indexPath.row], let category = self.category else { return }
        let publicationDetail = PublicationDetailController()
        publicationDetail.publication = publication
        publicationDetail.category = category
        navigationController?.pushViewController(publicationDetail, animated: true)
    }

}
