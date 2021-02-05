//
//  ViewController.swift
//  CocktailInfo
//
//  Created by Fábio Maciel de Sousa on 05/02/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    let dataSource = CocktailDataSource()
    private var requestObject: AnyObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = dataSource
        fetchData()
    }
    
    func fetchData() {
        let request = APIRequest(resource: DrinksResource())
        requestObject = request
        request.load { [weak self] result in
            switch result {
            case .success(let list):
                self?.dataSource.cocktails = list.drinks
                self?.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
