import SwiftUI

struct CartItemRow: View {
    let item: CartItem
    @Binding var cart: [CartItem] // Lien vers le panier
    
    var body: some View {
        HStack {
            // Image du produit
            AsyncImage(url: URL(string: item.photo)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 60, height: 60)
                    .clipped()
                    .cornerRadius(8)
            } placeholder: {
                Color.gray
                    .frame(width: 60, height: 60)
                    .cornerRadius(8)
            }
            
            VStack(alignment: .leading) {
                Text(item.name)
                    .font(.headline)
                Text("$\(String(format: "%.2f", item.price))")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            // Quantité
            HStack {
                Button(action: {
                    updateQuantity(increase: false)
                }) {
                    Image(systemName: "minus.circle")
                        .font(.title)
                        .foregroundColor(.blue)
                }
                
                Text("\(item.quantity)")
                    .font(.title2)
                    .frame(width: 40, alignment: .center)
                
                Button(action: {
                    updateQuantity(increase: true)
                }) {
                    Image(systemName: "plus.circle")
                        .font(.title)
                        .foregroundColor(.blue)
                }
            }
            
            // Bouton de suppression
            Button(action: {
                removeFromCart()
            }) {
                Image(systemName: "trash")
                    .foregroundColor(.red)
            }
            .padding(.leading)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: .gray.opacity(0.2), radius: 5, x: 0, y: 5)
    }
    
    // Mettre à jour la quantité d'un élément dans le panier
    func updateQuantity(increase: Bool) {
        if let index = cart.firstIndex(where: { $0.id == item.id }) {
            if increase {
                cart[index].quantity += 1
            } else if cart[index].quantity > 1 {
                cart[index].quantity -= 1
            }
        }
    }
    
    // Supprimer un élément du panier
    func removeFromCart() {
        if let index = cart.firstIndex(where: { $0.id == item.id }) {
            cart.remove(at: index)
        }
    }
}
