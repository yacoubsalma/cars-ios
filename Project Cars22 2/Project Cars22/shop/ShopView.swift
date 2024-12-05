import SwiftUI

struct ContentView: View {
    @State private var cart: [CartItem] = []  // Tableau représentant le panier
    @State private var search: String = ""
    @State private var selectedIndex: Int = 0
    @StateObject private var shopService = ShopService() // Service pour récupérer les pièces
    
    private let categories = ["All", "Engine", "Brakes", "Tires", "Lights", "Accessories"]
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(.systemGray6).ignoresSafeArea()
                
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading) {
                        
                        AppBarView(cart: $cart)
                        
                        TagLineView()
                            .padding(.horizontal)
                        
                        SearchAndScanView(search: $search)
                        
                        // Catégories
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(0..<categories.count) { i in
                                    Button(action: { selectedIndex = i }) {
                                        CategoryView(isActive: selectedIndex == i, text: categories[i])
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                        
                        Text("Popular Parts")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.horizontal)
                        
                        // Produits populaires
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 20) {
                                ForEach(shopService.items) { item in
                                    NavigationLink(destination: DetailScreen(shopItem: item, cart: $cart)) {
                                        ProductCardView(shopItem: item)
                                    }
                                }
                            }
                            .padding(.leading)
                        }
                        
                        Text("Best Selling Parts")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.horizontal)
                        
                        // Produits les plus vendus
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 20) {
                                ForEach(shopService.items) { item in
                                    NavigationLink(destination: DetailScreen(shopItem: item, cart: $cart)) {
                                        ProductCardView(shopItem: item)
                                    }
                                }
                            }
                            .padding(.leading)
                        }
                    }
                }
            }
            .onAppear {
                shopService.fetchShopItems() // Charger les données
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct AppBarView: View {
    @Binding var cart: [CartItem] // Lien vers le panier
    
    var body: some View {
        HStack {
            Button(action: {}) {
                Image(systemName: "line.horizontal.3")
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
            }
            Spacer()
            // Utilisation de NavigationLink pour la navigation vers le panier
            NavigationLink(destination: CartView(cart: $cart)) {
                Image(systemName: "cart")
                    .resizable()
                    .frame(width: 40, height: 40)
            }
        }
        .padding()
    }
}


struct TagLineView: View {
    var body: some View {
        Text("Find the\nBest ")
            .font(.largeTitle)
            .fontWeight(.bold)
            .foregroundColor(Color.blue) +
        Text("Car Parts!")
            .font(.largeTitle)
            .fontWeight(.bold)
            .foregroundColor(Color.red)
    }
}

struct SearchAndScanView: View {
    @Binding var search: String
    
    var body: some View {
        HStack {
            TextField("Search car parts", text: $search)
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .padding(.trailing, 8)
            
            Button(action: {}) {
                Image(systemName: "barcode.viewfinder")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding(.horizontal)
    }
}

struct CategoryView: View {
    let isActive: Bool
    let text: String
    
    var body: some View {
        VStack {
            Text(text)
                .font(.headline)
                .foregroundColor(isActive ? .blue : .gray)
            if isActive {
                Capsule()
                    .fill(Color.blue)
                    .frame(width: 20, height: 3)
            }
        }
        .padding(.trailing)
    }
}

struct ProductCardView: View {
    let shopItem: ShopItem
    
    var body: some View {
        VStack(alignment: .leading) {
            AsyncImage(url: URL(string: shopItem.photo)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 200, height: 150)
                    .clipped()
                    .cornerRadius(15)
            } placeholder: {
                Color.gray
                    .frame(width: 200, height: 150)
                    .cornerRadius(15)
            }
            
            Text(shopItem.name)
                .font(.headline)
                .fontWeight(.bold)
                .lineLimit(1)
                .padding(.top, 5)
            
            // Affichage du prix avec formatage
            Text("$\(String(format: "%.2f", shopItem.price))") // Affiche le prix avec 2 décimales
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .frame(width: 200)
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: .gray.opacity(0.2), radius: 5, x: 0, y: 5)
    }
}
