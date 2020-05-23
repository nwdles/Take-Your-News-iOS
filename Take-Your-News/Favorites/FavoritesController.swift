//
//  FavoritesController.swift
//  Take-Your-News
//
//  Created by Anastasiya on 21/05/2020.
//  Copyright © 2020 Anastasiya. All rights reserved.
//

import UIKit
import CoreData

class FavoritesController: UITableViewController {
    
    var favPublications = [FavPublication]()
    
    var favCategories = [FavCategory]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //  self.favPublications = CoreDataManager.shared.fetchPublications()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(handleReset))
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        
        self.refreshControl = refreshControl
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.favPublications = CoreDataManager.shared.fetchPublications()
        self.favCategories = CoreDataManager.shared.fetchCategories()
        
        tableView.reloadData()
    }
    
    @objc private func handleReset() {
        print("Deletee all")
        
        let context = CoreDataManager.shared.persistentContainer.viewContext
        
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: FavCategory.fetchRequest())
        do {
            try context.execute(batchDeleteRequest)
            
            var indexPathToRemove = [IndexPath]()
            
            for (indexSection, category) in favCategories.enumerated() {
                
                for (indexRow, _) in (category.publications?.enumerated())! {
                    print("\(indexSection) - \(indexRow)")
                    
                    let indexPath = IndexPath(row: indexRow , section: indexSection)
                    indexPathToRemove.append(indexPath)
                }
            }
            
            self.favCategories.removeAll()
            self.tableView.reloadData()
            
            let alert = UIAlertController(title: "All favorite posts deleted!", message: "You can refresh list from server", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true)
            
        } catch let delErr {
            print("failed delete \(delErr)")
        }
    }
    
    
    @objc private func handleRefresh(){
        print("refresh")
        
        self.refreshControl?.endRefreshing()

            CoreDataManager.shared.loadFavorites() {
            DispatchQueue.main.async {
            
            self.favPublications = CoreDataManager.shared.fetchPublications()
            self.favCategories = CoreDataManager.shared.fetchCategories()
            self.tableView.reloadData()
            }
        }
        
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //let count = favPublications.count
            let publications = favCategories[section].publications?.allObjects as! [FavPublication]
            let count = publications.count
            
            return count
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return favCategories.count
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = favCategories[section].name
        label.backgroundColor = #colorLiteral(red: 0.9995340705, green: 0.988355577, blue: 0.4726552367, alpha: 1)
        
        return label
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellFav", for: indexPath)
        //let publication = favPublications[indexPath.row]
        let publications = favCategories[indexPath.section].publications?.allObjects as! [FavPublication]
        let publication = publications[indexPath.row]
        cell.textLabel?.text = publication.header
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (_, _, completion) in
            let arrPublications = self.favCategories[indexPath.section].publications?.allObjects as! [FavPublication]
            let delPublication = arrPublications[indexPath.row]
            
            
            print(" delete: ", delPublication.header ?? "")
            
            //remove from tableview
            self.favCategories[indexPath.section].removeFromPublications(delPublication)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)

            //delete from coredata
            let context = CoreDataManager.shared.persistentContainer.viewContext
            
            context.delete(delPublication)
            do {
                try context.save()
            } catch let saveErr {
                print("Filed to delete \(saveErr.localizedDescription)")
                
                //perform edit
            }
            
            completion(true)
        }
        
        let swipeActions = UISwipeActionsConfiguration(actions: [deleteAction])
        
        return swipeActions
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let arrPublications = self.favCategories[indexPath.section].publications?.allObjects as! [FavPublication]
        let publication = arrPublications[indexPath.row]
        
        let publicationDetail = FavoriteDetailController()

        publicationDetail.publication = publication
        navigationController?.pushViewController(publicationDetail, animated: true)
        
    }
    
}
