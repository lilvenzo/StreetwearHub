import Foundation

struct CartItem: Identifiable {
    let id = UUID()
    let product: Product
    let size: String
    var quantity: Int
} 