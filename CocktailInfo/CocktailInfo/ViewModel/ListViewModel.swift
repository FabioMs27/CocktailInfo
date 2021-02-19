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
    @Published private(set) var errorDescription: String?
    
    private var requestObject: AnyObject?
    private var imageRequests = [String:AnyObject?]()
    
    /// Request data from the api and assign them to the models.
    /// - Parameter search: text from the search bar formatted for the query.
    func fetchData(By search: String? = nil) {
        let resource = CocktailResource(queryValue: search)
        let request = APIRequest(resource: resource)
        requestObject = request
        imageRequests.removeAll()
        request.load { [weak self] result in
            switch result {
            case .success(let drinks):
                let listedDrinks = drinks ?? []
                self?.drinks = listedDrinks.sorted(by: <)
                for (index, cocktail) in listedDrinks.enumerated() {
                    self?.fetchImage(from: cocktail, at: index)
                }
            case .failure(let error):
                self?.errorDescription = error.localizedDescription
            }
        }
    }
    
    /// Request image data from the api and assign it to the model.
    /// - Parameters:
    ///   - cocktail: the cocktail containing an url to the image.
    ///   - index: the index relative to the cocktail list.
    private func fetchImage(from cocktail: Cocktail, at index: Int) {
        let request = ImageRequest(url: cocktail.thumbNailUrl)
        imageRequests[cocktail.id] = request
        request.load { [weak self] result in
            switch result {
            case .success(let image):
                if index < self?.drinks.count ?? 0 {
                    self?.drinks[index].thumbImage = image
                }
            case .failure: break
            }
            self?.imageRequests[cocktail.id] = nil
        }
    }
}
