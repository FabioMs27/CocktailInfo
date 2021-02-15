//
//  CocktailDataSource.swift
//  CocktailInfo
//
//  Created by Fábio Maciel de Sousa on 05/02/21.
//

import UIKit

class CocktailDataSource: NSObject {
    var cocktails = [Cocktail]()
}

extension CocktailDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cocktails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CocktailTableViewCell") as? CocktailTableViewCell
        cell?.name = cocktails[indexPath.row].name
        cell?.category = cocktails[indexPath.row].category
        cell?.cocktailImage = cocktails[indexPath.row].thumbImage
        return cell ?? UITableViewCell()
    }
    
}
