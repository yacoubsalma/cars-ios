import Foundation

// Modèle représentant un article du panier
struct CartItem: Identifiable {
    let id: String
    let name: String
    let price: Double
    let photo: String
    var quantity: Int
}
