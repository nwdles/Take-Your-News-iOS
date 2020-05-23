//
//  PublicationDetail.swift
//  Take-Your-News
//
//  Created by Anastasiya on 18/05/2020.
//  Copyright © 2020 Anastasiya. All rights reserved.
//

import UIKit

class PublicationDetailController: UIViewController {

    var publication: Publication? {
        didSet {
            descriptionLabel.text = publication?.text
            headerLabel.text = publication?.header
            
            guard let strUrl = publication?.image else { return }
            let url = URL(string: strUrl)!
            
            DispatchQueue.global().async { [weak self] in
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self?.viewImg.image = image
                            self?.viewImg.contentMode = .scaleAspectFill
                            self?.viewImg.clipsToBounds = true
                        }
                    }
                }
            }
            viewImg.layer.cornerRadius = 5
            
        }
    }
    
    var category: Category?
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping

        return label
    }()
    
    let headerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        return label
    }()
    
    let viewImg: UIImageView = {
        let view = UIImageView()
       // view.backgroundColor = #colorLiteral(red: 0.9995340705, green: 0.988355577, blue: 0.4726552367, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = 10
        
        return stack
    }()
    
    let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        
        return scroll
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        setupLayout()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleFavorite))
    }
    
    
    @objc private func handleFavorite() {
        print("Fav")
    
        guard let addCategory = category, let addPublication = publication else { return }
        
        CoreDataManager.shared.createFavoritePublication(category: addCategory, publication: addPublication)
        
        let alert = UIAlertController(title: "This post added to favorite list!", message: "Check this in the favorites menu", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true)
        
    }
    
    private func setupLayout() {
        let guide = self.view.safeAreaLayoutGuide
        
        view.addSubview(scrollView)
        scrollView.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: guide.bottomAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: guide.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: guide.rightAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: guide.widthAnchor, multiplier: 1.0).isActive = true

        scrollView.addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        stackView.leftAnchor.constraint(equalTo: scrollView.leftAnchor).isActive = true
        stackView.rightAnchor.constraint(equalTo: scrollView.rightAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 1.0).isActive = true
        stackView.layoutMargins = UIEdgeInsets(top: 5, left: 10, bottom: 15, right: 10)
        stackView.isLayoutMarginsRelativeArrangement = true
        
        stackView.addArrangedSubview(headerLabel)
      /*  headerLabel.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 10).isActive = true
        headerLabel.centerXAnchor.constraint(equalTo: stackView.centerXAnchor).isActive = true*/
        
        stackView.addArrangedSubview(viewImg)
    /*    viewImg.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: 10).isActive = true
        viewImg.rightAnchor.constraint(equalTo: stackView.rightAnchor, constant: -10).isActive = true
        viewImg.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 20).isActive = true*/
        viewImg.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        stackView.addArrangedSubview(descriptionLabel)
     /*   descriptionLabel.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: 10).isActive = true
        descriptionLabel.rightAnchor.constraint(equalTo: stackView.rightAnchor, constant: -10).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: viewImg.bottomAnchor, constant: 15).isActive = true*/
    }
    

}
