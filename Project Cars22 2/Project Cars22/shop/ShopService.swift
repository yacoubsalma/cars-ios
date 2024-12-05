import SwiftUI

class ShopService: ObservableObject {
    @Published var items: [ShopItem] = []

    func fetchShopItems() {
        guard let url = URL(string: "http://localhost:3000/shop") else { return }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data {
                DispatchQueue.main.async {
                    do {
                        let decodedItems = try JSONDecoder().decode([ShopItem].self, from: data)
                        self.items = decodedItems
                    } catch {
                        print("Error decoding: \(error)")
                    }
                }
            }
        }.resume()
    }
    
    
 

    
    
}
   
