import UIKit

class MainAppViewController: UIViewController {

 
    @IBOutlet weak var collectionView: UICollectionView!
    
    var categories: CategoryList?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true

        NetworkingService.shared.createRequest(endpoint: "/categories", basicAuth: UserDefaults.standard.string(forKey: "basicAuth"), method: "GET") { [weak self] (result: Result<CategoryList, Error>) in
            switch result {
            case .success(let categories): self?.categories = categories
                
            self?.collectionView.register(UINib(nibName: "CategoryCell", bundle: nil), forCellWithReuseIdentifier: "CategoryCell")
            self?.collectionView.dataSource = self
            self?.collectionView.delegate = self
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        navigationItem.title = "Categories"
        
    }

}

extension MainAppViewController: UICollectionViewDataSource, UICollectionViewDelegate , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let count = categories?.data?.count else { return 0 }
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
        
        guard let category = categories?.data?[indexPath.item] else { return UICollectionViewCell()}
        cell.setupCell(category: category, name: category.name)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width / 2 - 10, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 5, bottom: 20, right: 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let category = categories?.data?[indexPath.item] else { return }
        let publicationController = PublicationController()
        publicationController.category = category
        navigationController?.pushViewController(publicationController, animated: true)
    }
    
    
}
