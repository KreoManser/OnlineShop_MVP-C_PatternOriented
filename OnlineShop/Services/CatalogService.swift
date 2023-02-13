//
//  CatalogService.swift
//  OnlineShop
//
//  Created by Сергей Бабич on 13.02.2023.
//

enum CatalogError: Error {
    case dropFiles
}

protocol CatalogService {
    func fetchProducts() async throws -> [Product]
}

class MockCatalogService: CatalogService {
    static let shared: MockCatalogService = .init()

    private let products: [Product] = [
        Product(name: "Avocado", description: "Very greeny fruit"),
        Product(name: "Browny", description: "Very browny fruit"),
        Product(name: "Valera", description: "Very moody person"),
        Product(name: "Reaper", description: "Very dangerous weapon"),
    ]

    func fetchProducts() async throws -> [Product] {
        try await Task.sleep(for: .seconds(1))
        if products.isEmpty {
            return []
        } else {
            return products
        }
    }
}
