//
//  ViewController.swift
//  CocktailInfo
//
//  Created by Fábio Maciel de Sousa on 05/02/21.
//

import UIKit

class ViewController: UIViewController {
    
    private var requestObject: AnyObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    }
    
    func fetchData() {
        let request = APIRequest(resource: DrinksResource())
        requestObject = request
        request.load { result in 
            switch result {
            case .success(let cocktail):
                print(cocktail)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
