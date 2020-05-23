//
//  CoreDataManager.swift
//  Take-Your-News
//
//  Created by Anastasiya on 20/05/2020.
//  Copyright © 2020 Anastasiya. All rights reserved.
//

import CoreData
import UIKit

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "FavoritesModel")
        container.loadPersistentStores { (storeDescription, err) in
            if let err = err {
                fatalError("Loading store failed \(err.localizedDescription)")
            }
        }
        return container
    }()
    
    func loadFavorites(completion: @escaping () -> Void) {
        NetworkingService.shared.requestFavorites(endpoint: "/favorites", basicAuth: UserDefaults.standard.string(forKey: "basicAuth")) { (result) in
            switch result {
            case .success(let favorites):
                //dump(favorites.data)
                DispatchQueue.global(qos: .background).async {
                let privateContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
                
                privateContext.parent = CoreDataManager.shared.persistentContainer.viewContext
                
                privateContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
                privateContext.parent?.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
                
                //  let privateContext = self.persistentContainer.viewContext
                //  privateContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
                
                guard let jsonFavorites = favorites.data else { return }
                
                jsonFavorites.forEach { (jsonFavorite) in
                    //print(jsonFavorite.name)
                    
                    let category = FavCategory(context: privateContext)
                    category.name = jsonFavorite.name
                    
                    
                    jsonFavorite.publications?.forEach({ (jsonPublication) in
                        //print("   \(jsonPublication.header)")
                        
                        let publication = FavPublication(context: privateContext)
                        publication.header = jsonPublication.header
                        publication.desc = jsonPublication.description
                        publication.text = jsonPublication.text
                        
                        if jsonPublication.image != nil {
                            let url = URL(string: jsonPublication.image!)!
                            if let data = try? Data(contentsOf: url) {
                                if let image = UIImage(data: data) {
                                    let imageData = image.jpegData(compressionQuality: 0.8)
                                    publication.image = imageData
                                }                                
                            }
                        }
                        
                        
                        
                        
                        category.addToPublications(publication)
                    })
                    
                    do {
                        try privateContext.save()
                        try privateContext.parent?.save()
                        
                    } catch let err {
                        print("err to save private context \(err)")
                    }
                    
                    completion()
                }
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        
        
    }
    
    func fetchPublications() -> [FavPublication] {
        let context = persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<FavPublication>(entityName: "FavPublication")
        
        do {
            let publications = try context.fetch(fetchRequest)
            return publications
            
        } catch let fetchErr {
            print("Failed to fetch \(fetchErr.localizedDescription)")
            return []
        }
    }
    
    func fetchCategories() -> [FavCategory] {
        let context = persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<FavCategory>(entityName: "FavCategory")
        fetchRequest.relationshipKeyPathsForPrefetching = ["FavPublication"]
        
        do {
            
            let categories = try context.fetch(fetchRequest)
            
            return categories
            
        } catch let fetchErr {
            print("Failed to fetch \(fetchErr.localizedDescription)")
            return []
        }
    }
    
    
    func createFavoritePublication(category: Category, publication: Publication) {
        let context = persistentContainer.viewContext
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        
        //create employee
        let favCategory = NSEntityDescription.insertNewObject(forEntityName: "FavCategory", into: context) as! FavCategory
        favCategory.name = category.name
        
        let favPublication = NSEntityDescription.insertNewObject(forEntityName: "FavPublication", into: context) as! FavPublication
        favPublication.category = favCategory
        favPublication.header = publication.header
        favPublication.desc = publication.description
        favPublication.text = publication.text
        
        do {
            //success
            try context.save()
            
        } catch let err {
            print("fail create employee \(err.localizedDescription)")
            
        }
    }
}
