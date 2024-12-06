struct Booking: Codable {
    let id: String
    let userId: String
    let date: String
    let problem: String
    var etat: Int
    let v: Int

    // Map the property names to JSON keys if needed
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case userId, date, problem, etat
        case v = "__v"
    }
}
