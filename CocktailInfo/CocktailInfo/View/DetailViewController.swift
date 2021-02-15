//
//  DetailViewController.swift
//  CocktailInfo
//
//  Created by Fábio Maciel de Sousa on 05/02/21.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak private var cocktailImage: UIImageView!
    @IBOutlet weak private var nameLabel: UILabel!
    @IBOutlet weak private var categoryLabel: UILabel!
    @IBOutlet weak private var alcoholicLabel: UILabel!
    @IBOutlet weak private var glassLabel: UILabel!
    @IBOutlet weak private var instructionsLabel: UILabel!
    
    var selectedCocktail: Cocktail?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = selectedCocktail?.name ?? ""
        nameLabel.setRoundedShadow()
        alcoholicLabel.text = selectedCocktail?.alcoholic ?? ""
        glassLabel.text = selectedCocktail?.glass ?? ""
        instructionsLabel.text = selectedCocktail?.instructions ?? ""
        cocktailImage.image = selectedCocktail?.thumbImage ?? UIImage()
        self.view.setHeightRelativeToDevice()
    }

}
