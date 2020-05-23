//
//  FavoriteCell.swift
//  Take-Your-News
//
//  Created by Anastasiya on 23/05/2020.
//  Copyright © 2020 Anastasiya. All rights reserved.
//

import UIKit

class FavoriteCell: UITableViewCell {
    
    var publication: FavPublication? {
        didSet {
            descriptionLabel.text = publication?.desc
            headerLabel.text = publication?.header
            
           if let imageData = publication?.image {
                viewImg.image = UIImage(data: imageData)
                viewImg.contentMode = .scaleAspectFill
                viewImg.clipsToBounds = true
            }
            viewImg.layer.cornerRadius = 5
        }
    }
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    let headerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    let viewImg: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
                
        let guide = self.safeAreaLayoutGuide
        
        addSubview(viewImg)
        viewImg.widthAnchor.constraint(equalToConstant: 100).isActive = true
        viewImg.heightAnchor.constraint(equalToConstant: 100).isActive = true
        viewImg.leftAnchor.constraint(equalTo: guide.leftAnchor, constant: 20).isActive = true
        viewImg.topAnchor.constraint(equalTo: guide.topAnchor, constant: 5).isActive = true
        
        addSubview(headerLabel)
        headerLabel.topAnchor.constraint(equalTo: guide.topAnchor, constant: 5).isActive = true
        headerLabel.leftAnchor.constraint(equalTo: viewImg.rightAnchor, constant: 10).isActive = true
        
        
        addSubview(descriptionLabel)
        descriptionLabel.rightAnchor.constraint(equalTo: guide.rightAnchor, constant: -20).isActive = true
        descriptionLabel.leftAnchor.constraint(equalTo: viewImg.rightAnchor, constant: 10).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 15).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
