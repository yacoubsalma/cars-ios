import SwiftUI

struct CheckoutView: View {
    @Binding var cart: [CartItem]
    var totalPrice: Double
    @State private var deliveryType: String = "Delivery"
    @State private var paymentType: String = "COD"
    @State private var promoCode: String = ""
    @State private var deliveryCost: Double = 0.0
    @State private var discount: Double = 0.0
    @State private var navigateToOrderAcceptView: Bool = false // Flag for navigation

    var body: some View {
        VStack(spacing: 20) {
            // Header
            HStack {
                Text("Checkout")
                    .font(.title2)
                    .bold()
                Spacer()
                Button(action: {
                    // Close action
                }) {
                    Image(systemName: "xmark")
                        .foregroundColor(.black)
                }
            }
            .padding(.horizontal)

            Divider()

            // Delivery Type
            VStack(alignment: .leading) {
                Text("Delivery Type")
                    .font(.headline)
                HStack {
                    Button(action: {
                        deliveryType = "Delivery"
                    }) {
                        Text("Delivery")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(deliveryType == "Delivery" ? Color.gray.opacity(0.2) : Color.clear)
                            .cornerRadius(10)
                    }
                    Button(action: {
                        deliveryType = "Collection"
                    }) {
                        Text("Collection")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(deliveryType == "Collection" ? Color.gray.opacity(0.2) : Color.clear)
                            .cornerRadius(10)
                    }
                }
                .frame(height: 40)
            }
            .padding(.horizontal)

            // Payment Type
            VStack(alignment: .leading) {
                Text("Payment Type")
                    .font(.headline)
                HStack {
                    Button(action: {
                        paymentType = "COD"
                    }) {
                        Text("COD")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(paymentType == "COD" ? Color.gray.opacity(0.2) : Color.clear)
                            .cornerRadius(10)
                    }
                    Button(action: {
                        paymentType = "Online"
                    }) {
                        Text("Online")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(paymentType == "Online" ? Color.gray.opacity(0.2) : Color.clear)
                            .cornerRadius(10)
                    }
                }
                .frame(height: 40)
            }
            .padding(.horizontal)

            // Price Details
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text("Total")
                    Spacer()
                    Text("$\(totalPrice, specifier: "%.2f")")
                }
                HStack {
                    Text("Delivery Cost")
                    Spacer()
                    Text("+ $\(deliveryCost, specifier: "%.2f")")
                }
                Divider()
                HStack {
                    Text("Final Total")
                        .bold()
                    Spacer()
                    Text("$\((totalPrice + deliveryCost), specifier: "%.2f")")
                        .bold()
                }
            }
            .padding(.horizontal)

            // Terms and Place Order
            VStack(spacing: 10) {
                Text("")
                    .font(.footnote)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.gray)

                // NavigationLink for Place Order button
                NavigationLink(destination: OrderAccpetView(), isActive: $navigateToOrderAcceptView) {
                    Button(action: {
                        // Trigger navigation when Place Order is clicked
                        navigateToOrderAcceptView = true
                    }) {
                        Text("Place Order")
                            .bold()
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)
                }
            }

            Spacer()
        }
        .padding()
        .navigationBarHidden(true)
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        @State var previewCart = [
            CartItem(id: "1", name: "Item 1", price: 10.0, photo: "photo1", quantity: 2),
            CartItem(id: "2", name: "Item 2", price: 20.0, photo: "photo2", quantity: 1)
        ]
        
        // Calculer le totalPrice pour l'aperçu
        let totalPrice = previewCart.reduce(0) { $0 + ($1.price * Double($1.quantity)) }
        
        return CheckoutView(cart: $previewCart, totalPrice: totalPrice)
    }
}
