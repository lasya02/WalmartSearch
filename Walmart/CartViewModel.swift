//
//  CartViewModel.swift
//  Walmart
//
//  Created by Lasya Kambhampati on 2/4/24.
//

import Foundation

@MainActor
class CartViewModel: ObservableObject {
    
    @Published var inCart: [Product] = []
    @Published var totalPrice: Double = 0.00
    
    func addToCart(product: Product){
        inCart.append(product)
        totalPrice += product.price * (100 - product.discountPercentage) / 100.0
        print("added to cart")
        print(inCart)
        print(totalPrice)
    }
    
    func removeFromCart(product: Product){
        inCart.remove(object: product)
        totalPrice -= product.price * (100 - product.discountPercentage) / 100.0
        if (totalPrice < 0.00){
            totalPrice = 0.00
        }
    }
    

    
}


extension Array where Element: Equatable {
    
    mutating func remove(object: Element) {
        guard let index = firstIndex(of: object) else {return}
        remove(at: index)
    }
}
