//
//  FavoriteDetailController.swift
//  Take-Your-News
//
//  Created by Anastasiya on 21/05/2020.
//  Copyright © 2020 Anastasiya. All rights reserved.
//

import UIKit

class FavoriteDetailController: UIViewController {

    var publication: FavPublication? {
        didSet {
            descriptionLabel.text = publication?.text
            headerLabel.text = publication?.header
            
            if let imageData = publication?.image {
                viewImg.image = UIImage(data: imageData)
                viewImg.contentMode = .scaleAspectFill
                viewImg.clipsToBounds = true
            }
            
        }
    }
    
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
        view.backgroundColor = #colorLiteral(red: 0.9995340705, green: 0.988355577, blue: 0.4726552367, alpha: 1)
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
        
        stackView.addArrangedSubview(viewImg)
        viewImg.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        stackView.addArrangedSubview(descriptionLabel)
    }

}
