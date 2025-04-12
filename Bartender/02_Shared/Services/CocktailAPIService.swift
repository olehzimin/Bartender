//
//  CocktailAPIService.swift
//  Bartender
//
//  Created by Oleh Zimin on 12.04.2025.
//

import Foundation

// Ckocktail API endpoints:
// all recipes - https://cocktail-api-84q3.onrender.com/recipes
// search recipe by name - https://cocktail-api-84q3.onrender.com/recipes?name=margarita
// search recipe by ingredient - https://cocktail-api-84q3.onrender.com/recipes?ingredient=absinthe
//
// all ingredients - https://cocktail-api-84q3.onrender.com/ingredients
// search ingredient by name - https://cocktail-api-84q3.onrender.com/ingredients?name=vodka

class CocktailAPIService {
    private enum CocktailAPIError: Error {
        case notFound
        case unexpectedStatusCode(code: Int)
        
        var localizedDescription: String {
            switch self {
            case .notFound:
                "No matching term was found"
            case .unexpectedStatusCode(let code):
                "Unexpected respose code: \(code)"
            }
        }
    }
    
    // Common JSONDecoder
    private let jsonDecoder = JSONDecoder()
    private let urlSession: URLSession = {
        var config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 300
        config.timeoutIntervalForResource = 300
        
        return URLSession(configuration: config)
    }()
    
    func fetchAllCocktails() async throws -> [Cocktail] {
        guard let url = URL(string: "https://cocktail-api-84q3.onrender.com/recipes") else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await urlSession.data(from: url)
        try validate(response)
        let cocktails = try jsonDecoder.decode([Cocktail].self, from: data)
        
        return cocktails
    }
    
    private func validate(_ response: URLResponse) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }
        
        switch httpResponse.statusCode {
        case 200...299:
            return
        case 404:
            throw CocktailAPIError.notFound
        default:
            throw CocktailAPIError.unexpectedStatusCode(code: httpResponse.statusCode)
        }
    }
}

