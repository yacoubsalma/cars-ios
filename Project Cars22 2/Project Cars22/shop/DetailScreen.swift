import SwiftUI

struct DetailScreen: View {
    let shopItem: ShopItem
    @State private var quantity: Int = 1
    @Binding var cart: [CartItem]  // Lien vers le panier
    @State private var showingAlert: Bool = false  // Contrôle de l'alerte
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Image du produit
                AsyncImage(url: URL(string: shopItem.photo)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 200)
                        .cornerRadius(15)
                } placeholder: {
                    Color.gray
                        .frame(height: 200)
                        .cornerRadius(15)
                }
                
                // Nom du produit
                Text(shopItem.name)
                    .font(.title)
                    .fontWeight(.bold)
                
                // Prix formaté
                Text("$\(String(format: "%.2f", shopItem.price))")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                // Description du produit
                if let description = shopItem.description, !description.isEmpty {
                    Text(description)
                        .font(.body)
                        .padding(.top, 10)
                        .foregroundColor(.gray)
                } else {
                    Text("No description available.")
                        .font(.body)
                        .padding(.top, 10)
                        .foregroundColor(.gray)
                }

                // Section de la quantité
                HStack {
                    Button(action: {
                        if quantity > 1 {
                            quantity -= 1
                        }
                    }) {
                        Image(systemName: "minus.circle")
                            .font(.title)
                            .foregroundColor(.blue)
                    }
                    
                    Text("\(quantity)")  // Affichage de la quantité
                        .font(.title2)
                        .frame(width: 40, alignment: .center)
                    
                    Button(action: {
                        quantity += 1
                    }) {
                        Image(systemName: "plus.circle")
                            .font(.title)
                            .foregroundColor(.blue)
                    }
                }
                .padding(.top, 20)

                // Bouton pour ajouter au panier
                Button(action: {
                    addToCart()
                    showingAlert = true  // Affiche l'alerte après l'ajout au panier
                }) {
                    Text("Add to Cart")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding(.top, 20)
            }
            .padding()
        }
        .navigationBarTitle("Product Details", displayMode: .inline)
        .alert(isPresented: $showingAlert) {
            Alert(
                title: Text("Item Added to Cart"),
                message: Text("\(shopItem.name) has been added to your cart."),
                dismissButton: .default(Text("OK"))
            )
        }
    }

    // Fonction pour ajouter un produit au panier
    func addToCart() {
        // Vérifiez si le produit existe déjà dans le panier
        if let index = cart.firstIndex(where: { $0.id == shopItem.id }) {
            // Si le produit est déjà dans le panier, mettez à jour la quantité
            cart[index].quantity += quantity
        } else {
            // Sinon, ajoutez-le au panier avec la quantité spécifiée
            let newCartItem = CartItem(id: shopItem.id, name: shopItem.name, price: shopItem.price, photo: shopItem.photo, quantity: quantity)
            cart.append(newCartItem)
        }
    }
}

