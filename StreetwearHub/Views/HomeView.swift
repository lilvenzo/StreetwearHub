//
//  HomeView.swift
//  StreetwearHub
//
//  Created by Venzislav on 17.03.25.
//

import SwiftUI

struct HomeView: View {
    @State private var selectedCategory: Product.Category?
    
    let categories: [Product.Category] = [.hoodies, .sneakers, .tshirts, .pants, .accessories]
    
    let featuredProducts = [
        Product(name: "Limited Edition Hoodie", brand: "Streetwear Co.", price: 120.00, imageName: "hoodie", description: "Premium cotton blend hoodie with unique design", sizes: ["S", "M", "L", "XL"], category: .hoodies),
        Product(name: "Classic Sneakers", brand: "Urban Kicks", price: 250.00, imageName: "sneakers", description: "Comfortable and stylish sneakers", sizes: ["40", "41", "42", "43"], category: .sneakers),
        Product(name: "Oversized Tee", brand: "Streetwear Co.", price: 80.00, imageName: "tee", description: "Relaxed fit t-shirt with bold graphics", sizes: ["S", "M", "L", "XL"], category: .tshirts)
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Featured Section
                    VStack(alignment: .leading) {
                        Text("Featured")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.horizontal)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 15) {
                                ForEach(featuredProducts) { product in
                                    NavigationLink(destination: ProductDetailView(product: product)) {
                                        FeaturedProductCard(product: product)
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    
                    // Categories
                    VStack(alignment: .leading) {
                        Text("Categories")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.horizontal)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 15) {
                                ForEach(categories, id: \.self) { category in
                                    CategoryButton(category: category, isSelected: selectedCategory == category) {
                                        selectedCategory = category
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    
                    // Products Grid
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 160))], spacing: 20) {
                        ForEach(featuredProducts) { product in
                            NavigationLink(destination: ProductDetailView(product: product)) {
                                ProductCard(product: product)
                            }
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("StreetwearHub")
        }
    }
}

struct FeaturedProductCard: View {
    let product: Product
    
    var body: some View {
        VStack(alignment: .leading) {
            Image(product.imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .cornerRadius(10)
            
            Text(product.brand)
                .font(.caption)
                .foregroundColor(.gray)
            
            Text(product.name)
                .font(.headline)
                .foregroundColor(.primary)
            
            Text(product.formattedPrice)
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .frame(width: 200)
    }
}

struct CategoryButton: View {
    let category: Product.Category
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(category.rawValue)
                .font(.subheadline)
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .background(isSelected ? Color.black : Color.gray.opacity(0.2))
                .foregroundColor(isSelected ? .white : .primary)
                .cornerRadius(20)
        }
    }
}

struct ProductCard: View {
    let product: Product
    
    var body: some View {
        VStack(alignment: .leading) {
            Image(product.imageName)
                .resizable()
                .scaledToFit()
                .frame(height: 150)
                .cornerRadius(10)
            
            Text(product.brand)
                .font(.caption)
                .foregroundColor(.gray)
            
            Text(product.name)
                .font(.headline)
                .foregroundColor(.primary)
                .lineLimit(2)
            
            Text(product.formattedPrice)
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 5)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(CartManager.shared)
            .preferredColorScheme(.light)
    }
}
