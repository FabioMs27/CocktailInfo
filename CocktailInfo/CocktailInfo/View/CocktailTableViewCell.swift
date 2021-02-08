//
//  CocktailTableViewCell.swift
//  CocktailInfo
//
//  Created by Fábio Maciel de Sousa on 05/02/21.
//

import UIKit

class CocktailTableViewCell: UITableViewCell {
    @IBOutlet private weak var thumbNail: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var categoryLabel: UILabel!
    
    var cocktailImage: UIImage? {
        willSet { thumbNail.image = newValue ?? UIImage() }
    }
    
    var name: String? {
        willSet { nameLabel.text = newValue ?? "" }
    }
    
    var category: String? {
        willSet { categoryLabel.text = newValue ?? "" }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        thumbNail.setRoundedShadow()
    }
    
}
