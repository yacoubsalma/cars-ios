import SwiftUI

struct CartView: View {
    @Binding var cart: [CartItem] // Lien vers le panier
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    if cart.isEmpty {
                        Text("Your cart is empty")
                            .font(.title)
                            .foregroundColor(.gray)
                            .padding()
                    } else {
                        // Afficher les éléments du panier
                        ForEach(cart) { item in
                            CartItemRow(item: item, cart: $cart) // Passez le lien vers le panier
                        }
                        
                        // Afficher le total
                        Text("Total: $\(String(format: "%.2f", totalPrice()))")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.top)
                            .padding(.horizontal)
                    }
                    
                    // Bouton pour passer à la caisse
                    if !cart.isEmpty {
                        NavigationLink(destination: CheckoutView(cart: $cart, totalPrice: totalPrice())) {
                            Text("Proceed to Checkout")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.blue)
                                .cornerRadius(10)
                                .padding(.horizontal)
                        }
                    }
                }
                .padding()
            }
            .navigationBarTitle("Your Cart", displayMode: .inline)
        }
    }
    
    // Calculer le prix total du panier
    func totalPrice() -> Double {
        return cart.reduce(0) { $0 + ($1.price * Double($1.quantity)) }
    }
}
