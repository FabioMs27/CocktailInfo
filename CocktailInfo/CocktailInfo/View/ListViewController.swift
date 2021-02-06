//
//  ViewController.swift
//  CocktailInfo
//
//  Created by Fábio Maciel de Sousa on 05/02/21.
//

import UIKit

class ListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    let dataSource = CocktailDataSource()
    private var requestObject: AnyObject?
    private var imageRequests = [String:AnyObject?]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = dataSource
        fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let row = tableView.indexPathForSelectedRow?.row {
            let selectedCocktail = dataSource.cocktails[row]
            let selectedImage = dataSource.thumbNails[row]
            guard let detailViewController = segue.destination as? DetailViewController else {
                return
            }
            detailViewController.selectedCocktail = selectedCocktail
            detailViewController.selectedImage = selectedImage
        }
    }
    
    func fetchData() {
        let request = APIRequest(resource: DrinksResource())
        requestObject = request
        request.load { [weak self] result in
            switch result {
            case .success(let list):
                self?.dataSource.thumbNails = [UIImage?](repeating: nil, count: list.drinks.count)
                for (index, cocktail) in list.drinks.enumerated() {
                    self?.fetchImage(from: cocktail, at: index)
                }
                self?.dataSource.cocktails = list.drinks
                self?.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchImage(from cocktail: Cocktail, at index: Int) {
        let request = ImageRequest(url: cocktail.thumbNailUrl)
        imageRequests[cocktail.id] = request
        request.load { [weak self] result in
            switch result {
            case .success(let image):
                self?.dataSource.thumbNails[index] = image
                self?.tableView.reloadData()
                self?.imageRequests[cocktail.id] = nil
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
