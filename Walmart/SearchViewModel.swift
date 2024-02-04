//
//  SearchViewModel.swift
//  Walmart
//
//  Created by Lasya Kambhampati on 2/3/24.
//

import Foundation

enum SearchLoadingState {
    case error(error: Error)
    case loading
    case success(products: [Product])
    case successSpecific(products: [Product])
    case idle
}

@MainActor
class SearchViewModel: ObservableObject {
    @Published var products: [Product] = []
    @Published var state: SearchLoadingState = .idle
    @Published var searchText: String = ""


    func searchProducts() async {
        do {
            self.state = .loading
            
            let products = try await SearchService.findProducts()
            
            
            let convertedProducts: [()] = products.map { product in
               
            }
            self.state = .success(products: products)
    
        } catch {
            self.state = .error(error: error)
        }
    }
    
    
    func searchSpecificProducts() async {
        do {
            self.state = .loading
            
            let products = try await SearchService.findSpecificProducts(search: searchText)
            
            
            let _: [()] = products.map { product in
               
            }
            self.state = .success(products: products)
    
        } catch {
            self.state = .error(error: error)
        }
    }
    
    func filterRating(rating: Double) {
        print("entered")
        
        do {
            self.state = .loading
            
            let filteredProducts: [Product] = products.filter { name in
                print(name.rating)
                print(rating)
                if name.rating >= rating {
                    return true
                }
                else{
                    return false
                }
            }
            print(filteredProducts)
            
            self.state = .success(products: filteredProducts)
        } 
        
       
        
    }

}
