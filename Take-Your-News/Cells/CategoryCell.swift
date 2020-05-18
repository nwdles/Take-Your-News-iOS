//
//  CategoryCell.swift
//  Take-Your-News
//
//  Created by Anastasiya on 18/05/2020.
//  Copyright © 2020 Anastasiya. All rights reserved.
//

import UIKit

class CategoryCell: UICollectionViewCell {

    @IBOutlet weak var titleCategory: UILabel!
    @IBOutlet weak var categoryImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.categoryImage.image = nil
    }
    
    func setupCell(category: Category, name: String) {
      //  self.categoryImage.image = UIImage(named: "test")
        self.titleCategory.text = name
    }

}
