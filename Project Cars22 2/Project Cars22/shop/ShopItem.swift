struct ShopItem: Identifiable, Codable {
    let id: String
    let name: String
    let price: Double  // Changez ici le type de String à Double
    let photo: String
    let description: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name
        case price
        case photo
        case description
    }
}
