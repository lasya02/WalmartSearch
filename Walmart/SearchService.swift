//
//  SearchService.swift
//  Walmart
//
//  Created by Lasya Kambhampati on 2/3/24.
//

import Foundation

enum SearchService{
    
    private static let session = URLSession.shared
    private static var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
    
    public static func findProducts() async throws -> [Product]{
        let components = URLComponents(string: "https://dummyjson.com/products")
        guard let url = components?.url else { fatalError("Invalid URL") }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let decodedData = try decoder.decode(ProductResponse.self, from: data)
        
        print(decodedData)
        
        return decodedData.products
    }
    
    public static func findSpecificProducts(search: String) async throws -> [Product]{
        
        var components = URLComponents(string: "https://dummyjson.com/products/search")
        
        components?.queryItems = [
            URLQueryItem(name: "q", value: "\(search)"),
        ]
        
        guard let url = components?.url else { fatalError("Invalid URL") }
        
        var request = URLRequest(url: url)

        print(url)
        print(request)
        
        
        let (data, _) = try await session.data(for: request)

//        let (data, _) = try await URLSession.shared.data(from: url)
        
        let decodedData = try decoder.decode(ProductResponse.self, from: data)
        
  
        
        return decodedData.products
    }
    

}
