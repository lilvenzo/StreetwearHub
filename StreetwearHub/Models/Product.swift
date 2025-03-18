import Foundation

struct Product: Identifiable {
    let id = UUID()
    let name: String
    let brand: String
    let price: Double
    let imageName: String
    let description: String
    let sizes: [String]
    let category: Category
    
    var formattedPrice: String {
        return String(format: "$%.2f", price)
    }
}

// MARK: - Product Category
extension Product {
    enum Category: String, CaseIterable {
        case hoodies = "Hoodies"
        case sneakers = "Sneakers"
        case tshirts = "T-Shirts"
        case pants = "Pants"
        case accessories = "Accessories"
    }
} 