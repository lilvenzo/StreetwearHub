import Foundation

extension Product {
    static let sampleProducts = [
        Product(
            name: "Limited Edition Hoodie",
            brand: "Streetwear Co.",
            price: 120.00,
            imageName: "hoodie",
            description: "Premium cotton blend hoodie with unique design",
            sizes: ["S", "M", "L", "XL"],
            category: .hoodies
        ),
        Product(
            name: "Classic Sneakers",
            brand: "Urban Kicks",
            price: 250.00,
            imageName: "sneakers",
            description: "Comfortable and stylish sneakers",
            sizes: ["40", "41", "42", "43"],
            category: .sneakers
        ),
        Product(
            name: "Oversized Tee",
            brand: "Streetwear Co.",
            price: 80.00,
            imageName: "tee",
            description: "Relaxed fit t-shirt with bold graphics",
            sizes: ["S", "M", "L", "XL"],
            category: .tshirts
        )
    ]
    
    static let sample = sampleProducts[0]
} 