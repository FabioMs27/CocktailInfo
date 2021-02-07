//
//  ListViewModel.swift
//  CocktailInfo
//
//  Created by Fábio Maciel de Sousa on 07/02/21.
//

import Foundation
import Combine
import UIKit

class ListViewModel: ObservableObject {
    
    @Published private(set) var drinks = [Cocktail]()
    @Published private(set) var images = [UIImage?]()
    @Published private(set) var errorDescription: String?
    
    private var requestObject: AnyObject?
    private var imageRequests = [String:AnyObject?]()
    
    func fetchData() {
        let request = APIRequest(resource: DrinksResource())
        requestObject = request
        request.load { [weak self] result in
            switch result {
            case .success(let list):
                self?.drinks = list.drinks.sorted(by: <)
                self?.images = [UIImage?](repeating: nil, count: list.drinks.count)
                for (index, cocktail) in list.drinks.enumerated() {
                    self?.fetchImage(from: cocktail, at: index)
                }
            case .failure(let error):
                self?.errorDescription = error.localizedDescription
            }
        }
    }
    
    func fetchImage(from cocktail: Cocktail, at index: Int) {
        let request = ImageRequest(url: cocktail.thumbNailUrl)
        imageRequests[cocktail.id] = request
        request.load { [weak self] result in
            switch result {
            case .success(let image):
                self?.images[index] = image
                self?.imageRequests[cocktail.id] = nil
                print(image)
            case .failure(let error):
                self?.errorDescription = error.localizedDescription
            }
        }
    }
}
