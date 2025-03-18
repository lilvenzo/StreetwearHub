import SwiftUI

struct CartView: View {
    @EnvironmentObject var cartManager: CartManager
    @State private var showingCheckout = false
    
    var body: some View {
        NavigationView {
            if cartManager.items.isEmpty {
                EmptyCartView()
            } else {
                VStack(spacing: 0) {
                    List {
                        ForEach(cartManager.items) { item in
                            CartItemRow(item: item)
                        }
                        .onDelete { indexSet in
                            indexSet.forEach { index in
                                cartManager.removeItem(cartManager.items[index])
                            }
                        }
                    }
                    
                    // Bottom checkout section
                    VStack(spacing: 16) {
                        HStack {
                            Text("Total")
                                .font(.headline)
                            Spacer()
                            Text(String(format: "$%.2f", cartManager.total))
                                .font(.title3)
                                .fontWeight(.semibold)
                        }
                        
                        Button(action: {
                            showingCheckout = true
                        }) {
                            HStack {
                                Text("Proceed to Checkout")
                                    .fontWeight(.semibold)
                                
                                Image(systemName: "arrow.right")
                                    .font(.body.weight(.semibold))
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(Color.black)
                            .foregroundColor(.white)
                            .cornerRadius(15)
                        }
                        .disabled(cartManager.items.isEmpty)
                    }
                    .padding()
                    .background(Color(.systemBackground))
                    .overlay(
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(Color(.systemGray5)),
                        alignment: .top
                    )
                }
                .navigationTitle("Shopping Cart")
                .sheet(isPresented: $showingCheckout) {
                    CheckoutView()
                }
            }
        }
    }
}

struct CartItemRow: View {
    let item: CartItem
    @EnvironmentObject var cartManager: CartManager
    
    var body: some View {
        HStack(spacing: 15) {
            Image(item.product.imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .cornerRadius(8)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(item.product.brand)
                    .font(.caption)
                    .foregroundColor(.gray)
                
                Text(item.product.name)
                    .font(.subheadline)
                
                Text("Size: \(item.size)")
                    .font(.caption)
                    .foregroundColor(.gray)
                
                Text(item.product.formattedPrice)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            // Quantity control
            HStack(spacing: 8) {
                Button(action: {
                    if item.quantity > 1 {
                        cartManager.updateQuantity(for: item, quantity: item.quantity - 1)
                    }
                }) {
                    Image(systemName: "minus.circle.fill")
                        .foregroundColor(.gray)
                        .contentShape(Rectangle()) // Make hit area match visual size
                }
                .buttonStyle(PlainButtonStyle()) // Prevent list selection
                            
                Text("\(item.quantity)")
                    .frame(minWidth: 20)
                    .font(.body)
                            
                Button(action: {
                    cartManager.updateQuantity(for: item, quantity: item.quantity + 1)
                }) {
                    Image(systemName: "plus.circle.fill")
                        .foregroundColor(.black)
                        .contentShape(Rectangle()) // Make hit area match visual size
                }
                .buttonStyle(PlainButtonStyle()) // Prevent list selection
            }
            .font(.system(size: 20))
        }
        .padding(.vertical, 8)
    }
}

struct EmptyCartView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "cart")
                .font(.system(size: 60))
                .foregroundColor(.gray)
            
            Text("Your cart is empty")
                .font(.title2)
                .fontWeight(.medium)
            
            Text("Add some items to your cart")
                .foregroundColor(.gray)
            
            NavigationLink(destination: HomeView()) {
                Text("Continue Shopping")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: 200, height: 50)
                    .background(Color.black)
                    .cornerRadius(25)
            }
        }
        .navigationTitle("Shopping Cart")
    }
}

struct CheckoutView: View {
    @EnvironmentObject var cartManager: CartManager
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Order Summary")) {
                    ForEach(cartManager.items) { item in
                        HStack {
                            Text(item.product.name)
                            Spacer()
                            Text("\(item.quantity)x")
                            Text(item.product.formattedPrice)
                        }
                    }
                    
                    HStack {
                        Text("Total")
                            .font(.headline)
                        Spacer()
                        Text(String(format: "$%.2f", cartManager.total))
                            .font(.headline)
                    }
                }
                
                Section(header: Text("Payment Information")) {
                    TextField("Card Number", text: .constant(""))
                    TextField("Expiry Date", text: .constant(""))
                    TextField("CVV", text: .constant(""))
                }
                
                Section {
                    Button("Place Order") {
                        // Handle order placement
                        dismiss()
                    }
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.black)
                    .cornerRadius(10)
                }
            }
            .navigationTitle("Checkout")
            .navigationBarItems(trailing: Button("Cancel") {
                dismiss()
            })
        }
    }
}

#Preview {
    CartView()
        .environmentObject(CartManager.shared)
} 
