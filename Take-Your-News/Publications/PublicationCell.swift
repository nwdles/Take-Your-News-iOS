//
//  PublicationCell.swift
//  Take-Your-News
//
//  Created by Anastasiya on 18/05/2020.
//  Copyright © 2020 Anastasiya. All rights reserved.
//

import UIKit

class PublicationCell: UITableViewCell {

    var publication: Publication? {
        didSet {
            descriptionLabel.text = publication?.description
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
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    let viewImg: UIImageView = {
        let view = UIImageView()
      //  view.backgroundColor = #colorLiteral(red: 0.9995340705, green: 0.988355577, blue: 0.4726552367, alpha: 1)
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
        viewImg.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: -5).isActive = true
        
        addSubview(headerLabel)
        headerLabel.topAnchor.constraint(equalTo: guide.topAnchor, constant: 5).isActive = true
        headerLabel.leftAnchor.constraint(equalTo: viewImg.rightAnchor, constant: 10).isActive = true
        
        
        addSubview(descriptionLabel)
        descriptionLabel.rightAnchor.constraint(equalTo: guide.rightAnchor, constant: -20).isActive = true
        descriptionLabel.leftAnchor.constraint(equalTo: viewImg.rightAnchor, constant: 10).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 15).isActive = true
        //descriptionLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
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
