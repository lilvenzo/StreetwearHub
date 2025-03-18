import Foundation

final class CartManager: ObservableObject {
    static let shared = CartManager()
    
    @Published var items: [CartItem] = []
    
    var total: Double {
        items.reduce(0) { $0 + ($1.product.price * Double($1.quantity)) }
    }
    
    func addItem(_ product: Product, size: String) {
        if let index = items.firstIndex(where: { $0.product.id == product.id && $0.size == size }) {
            items[index].quantity += 1
        } else {
            items.append(CartItem(product: product, size: size, quantity: 1))
        }
    }
    
    func removeItem(_ item: CartItem) {
        items.removeAll { $0.id == item.id }
    }
    
    func updateQuantity(for item: CartItem, quantity: Int) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index].quantity = quantity
        }
    }
    
    private init() {} // Make init private for singleton pattern
} 