//
//  ProductResponse.swift
//  Walmart
//
//  Created by Lasya Kambhampati on 2/3/24.
//

import Foundation

struct ProductResponse: Codable{
    let products: [Product]
    let total: Int
    let skip: Int
    let limit: Int
}

struct Product: Codable, Identifiable{
    let id: Int
    let title: String
    let description: String
    let price: Double
    let discountPercentage: Double
    let rating: Double
    let stock: Int
    let brand: String
    let category: String
    let thumbnail: String
    let images: [String]
}

var example = Product(
    id: 1,
    title: "iPhone 9",
    description: "An apple mobile which is nothing like apple",
    price: 549,
    discountPercentage: 12.96,
    rating: 4.69,
    stock: 94,
    brand: "Apple",
    category: "smartphones",
    thumbnail: "...",
    images: ["...", "...", "..."]
)

