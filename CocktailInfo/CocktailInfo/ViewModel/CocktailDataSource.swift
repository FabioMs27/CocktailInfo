//
//  CocktailDataSource.swift
//  CocktailInfo
//
//  Created by Fábio Maciel de Sousa on 05/02/21.
//

import UIKit

class CocktailDataSource: NSObject {
    var cocktails = [Cocktail]()
    var categories = [String]()
    private(set) var cocktailByCategory = [[Cocktail]]()
    private var filteredCategories = [String]()
    
    func updateCocktailByCategory() {
        cocktailByCategory.removeAll()
        filteredCategories.removeAll()
        for category in categories {
            let filteredCocktails = cocktails.filter { category == $0 }
            if !filteredCocktails.isEmpty {
                filteredCategories.append(category)
                cocktailByCategory.append(filteredCocktails)
            }
        }
    }
}

extension CocktailDataSource: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return filteredCategories.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return filteredCategories[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cocktailByCategory[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CocktailTableViewCell") as? CocktailTableViewCell else {
            fatalError("CocktailTableViewCell couldn't load!")
        }
        let cocktail = cocktailByCategory[indexPath.section][indexPath.row]
        cell.name = cocktail.name
        cell.category = cocktail.category
        cell.cocktailImage = cocktail.thumbImage
        return cell
    }
    
}
