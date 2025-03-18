//
//  ProductDetailView.swift
//  StreetwearHub
//
//  Created by Venzislav on 17.03.25.
//

import SwiftUI

struct ProductDetailView: View {
    let product: Product
    @State private var selectedSize: String?
    @EnvironmentObject var cartManager: CartManager
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Product Image
                Image(product.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                    .frame(height: 400)
                    .clipped()
                
                VStack(alignment: .leading, spacing: 16) {
                    // Brand and Name
                    VStack(alignment: .leading, spacing: 8) {
                        Text(product.brand)
                            .font(.headline)
                            .foregroundColor(.gray)
                        
                        Text(product.name)
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Text(product.formattedPrice)
                            .font(.title2)
                            .fontWeight(.semibold)
                    }
                    .padding(.horizontal)
                    
                    // Description
                    Text("Description")
                        .font(.headline)
                        .padding(.horizontal)
                    
                    Text(product.description)
                        .font(.body)
                        .foregroundColor(.secondary)
                        .padding(.horizontal)
                    
                    // Size Selection
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Select Size")
                            .font(.headline)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 12) {
                                ForEach(product.sizes, id: \.self) { size in
                                    SizeButton(size: size,
                                             isSelected: selectedSize == size) {
                                        selectedSize = size
                                    }
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                    
                    // Add to Cart Button
                    Button(action: {
                        if let size = selectedSize {
                            cartManager.addItem(product, size: size)
                            dismiss()
                        }
                    }) {
                        HStack {
                            Text("Add to Cart")
                                .fontWeight(.semibold)
                            
                            Spacer()
                            
                            Text(product.formattedPrice)
                                .fontWeight(.semibold)
                        }
                        .foregroundColor(.white)
                        .padding()
                        .background(selectedSize != nil ? Color.black : Color.gray)
                        .cornerRadius(15)
                    }
                    .disabled(selectedSize == nil)
                    .padding()
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct SizeButton: View {
    let size: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(size)
                .font(.system(.body, design: .rounded))
                .fontWeight(.medium)
                .frame(width: 60, height: 60)
                .background(isSelected ? Color.black : Color(.systemBackground))
                .foregroundColor(isSelected ? .white : .primary)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(isSelected ? Color.black : Color.gray.opacity(0.3), lineWidth: 1)
                )
        }
        .cornerRadius(12)
    }
}

#Preview {
    NavigationView {
        ProductDetailView(product: Product.sample)
            .environmentObject(CartManager.shared)
    }
}
