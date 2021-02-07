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
    
    func fetchData(By search: String? = nil) {
        let resource = DrinksResource(queryValue: search)
        let request = APIRequest(resource: resource)
        requestObject = request
        imageRequests.removeAll()
        request.load { [weak self] result in
            switch result {
            case .success(let list):
                guard let listedDrinks = list.drinks else { return }
                self?.drinks = listedDrinks.sorted(by: <)
                self?.images = [UIImage?](repeating: nil, count: listedDrinks.count)
                for (index, cocktail) in listedDrinks.enumerated() {
                    self?.fetchImage(from: cocktail, at: index)
                }
            case .failure(let error):
                self?.errorDescription = error.localizedDescription
            }
        }
    }
    
    private func fetchImage(from cocktail: Cocktail, at index: Int) {
        let request = ImageRequest(url: cocktail.thumbNailUrl)
        imageRequests[cocktail.id] = request
        request.load { [weak self] result in
            switch result {
            case .success(let image):
                if index < self?.images.count ?? 0 {
                    self?.images[index] = image
                }
            case .failure: break
            }
            self?.imageRequests[cocktail.id] = nil
        }
    }
}
