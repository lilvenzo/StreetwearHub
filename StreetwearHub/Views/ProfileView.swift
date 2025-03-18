//
//  ProfileView.swift
//  StreetwearHub
//
//  Created by Venzislav on 17.03.25.
//

import SwiftUI

struct UserProfile {
    var name: String
    var email: String
    var phone: String
    var address: String
    var orders: [Order]
}

struct Order: Identifiable {
    let id = UUID()
    let date: Date
    let items: [CartItem]
    let total: Double
    let status: OrderStatus
    
    enum OrderStatus: String {
        case processing = "Processing"
        case shipped = "Shipped"
        case delivered = "Delivered"
        case cancelled = "Cancelled"
    }
}

struct ProfileView: View {
    @State private var userProfile = UserProfile(
        name: "John Doe",
        email: "john@example.com",
        phone: "+1 234 567 890",
        address: "123 Street Name, City, Country",
        orders: []
    )
    
    @State private var showingEditProfile = false
    @State private var showingOrders = false
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    HStack {
                        Image(systemName: "person.circle.fill")
                            .font(.system(size: 60))
                            .foregroundColor(.gray)
                        
                        VStack(alignment: .leading) {
                            Text(userProfile.name)
                                .font(.headline)
                            Text(userProfile.email)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(.vertical, 8)
                }
                
                Section(header: Text("Account")) {
                    NavigationLink(destination: EditProfileView(profile: $userProfile)) {
                        Label("Edit Profile", systemImage: "pencil")
                    }
                    
                    NavigationLink(destination: AddressesView()) {
                        Label("Addresses", systemImage: "location")
                    }
                    
                    NavigationLink(destination: PaymentMethodsView()) {
                        Label("Payment Methods", systemImage: "creditcard")
                    }
                }
                
                Section(header: Text("Orders")) {
                    NavigationLink(destination: OrdersView(orders: userProfile.orders)) {
                        Label("Order History", systemImage: "clock")
                    }
                    
                    NavigationLink(destination: WishlistView()) {
                        Label("Wishlist", systemImage: "heart")
                    }
                }
                
                Section(header: Text("Settings")) {
                    NavigationLink(destination: NotificationsView()) {
                        Label("Notifications", systemImage: "bell")
                    }
                    
                    NavigationLink(destination: PrivacyView()) {
                        Label("Privacy", systemImage: "lock")
                    }
                    
                    NavigationLink(destination: HelpView()) {
                        Label("Help & Support", systemImage: "questionmark.circle")
                    }
                }
                
                Section {
                    Button(action: {
                        // Handle logout
                    }) {
                        Label("Log Out", systemImage: "arrow.right.square")
                            .foregroundColor(.red)
                    }
                }
            }
            .navigationTitle("Profile")
        }
    }
}

struct EditProfileView: View {
    @Binding var profile: UserProfile
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Form {
            Section(header: Text("Personal Information")) {
                TextField("Name", text: $profile.name)
                TextField("Email", text: $profile.email)
                TextField("Phone", text: $profile.phone)
            }
            
            Section(header: Text("Address")) {
                TextEditor(text: $profile.address)
                    .frame(height: 100)
            }
            
            Section {
                Button("Save Changes") {
                    dismiss()
                }
                .frame(maxWidth: .infinity)
                .foregroundColor(.white)
                .padding()
                .background(Color.black)
                .cornerRadius(10)
            }
        }
        .navigationTitle("Edit Profile")
    }
}

struct OrdersView: View {
    let orders: [Order]
    
    var body: some View {
        List {
            ForEach(orders) { order in
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text("Order #\(order.id.uuidString.prefix(8))")
                            .font(.headline)
                        Spacer()
                        Text(order.date, style: .date)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    
                    ForEach(order.items) { item in
                        HStack {
                            Text(item.product.name)
                            Spacer()
                            Text("\(item.quantity)x")
                            Text(item.product.formattedPrice)
                        }
                        .font(.subheadline)
                    }
                    
                    HStack {
                        Text("Total")
                            .font(.headline)
                        Spacer()
                        Text(String(format: "$%.2f", order.total))
                            .font(.headline)
                    }
                    
                    Text(order.status.rawValue)
                        .font(.caption)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(statusColor(for: order.status))
                        .foregroundColor(.white)
                        .cornerRadius(4)
                }
                .padding(.vertical, 8)
            }
        }
        .navigationTitle("Order History")
    }
    
    private func statusColor(for status: Order.OrderStatus) -> Color {
        switch status {
        case .processing:
            return .orange
        case .shipped:
            return .blue
        case .delivered:
            return .green
        case .cancelled:
            return .red
        }
    }
}

struct AddressesView: View {
    var body: some View {
        Text("Addresses View")
            .navigationTitle("Addresses")
    }
}

struct PaymentMethodsView: View {
    var body: some View {
        Text("Payment Methods View")
            .navigationTitle("Payment Methods")
    }
}

struct WishlistView: View {
    var body: some View {
        Text("Wishlist View")
            .navigationTitle("Wishlist")
    }
}

struct NotificationsView: View {
    var body: some View {
        Text("Notifications View")
            .navigationTitle("Notifications")
    }
}

struct PrivacyView: View {
    var body: some View {
        Text("Privacy View")
            .navigationTitle("Privacy")
    }
}

struct HelpView: View {
    var body: some View {
        Text("Help View")
            .navigationTitle("Help & Support")
    }
}

#Preview {
    ProfileView()
}
