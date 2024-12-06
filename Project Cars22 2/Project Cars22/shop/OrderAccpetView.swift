//
//  OrderAccpetView.swift
//  OnlineGroceriesSwiftUI
//
//  Created by CodeForAny on 14/08/23.
//

import SwiftUI

struct OrderAccpetView: View {
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var body: some View {
        ZStack {
            // Image d'arrière-plan
            Image("bottom_bg")
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            
            VStack {
                Spacer()
                
                // Image de commande acceptée
                Image("order_accpeted")
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.main.bounds.width * 0.7)
                    .padding(.bottom, 32)
                
                // Texte "Votre commande a été acceptée"
                Text("Your order has been \n accepted")
                    .multilineTextAlignment(.center)
                    .font(.system(size: 28, weight: .semibold)) // Police standard avec poids "semibold"
                    .foregroundColor(.black) // Texte noir
                    .padding(.bottom, 12)
                
                // Texte de confirmation de commande
                Text("Your items have been placed and are on\n their way to being processed")
                    .multilineTextAlignment(.center)
                    .font(.system(size: 16, weight: .regular)) // Police standard avec poids "regular"
                    .foregroundColor(.black) // Texte noir
                    .padding(.bottom, 12)
                
                Spacer()
                Spacer()
                
                // Bouton pour revenir à la page d'accueil
                RoundButton(title: "Back to home") {
                    // Action pour suivre la commande
                }
                
               
                .padding(.bottom, 70) // Espace en bas
            }
            .padding(.horizontal, 20) // Espacement horizontal pour tous les éléments dans le VStack
        }
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .ignoresSafeArea() // Ignore les zones sécurisées
    }
}

struct OrderAccpetView_Previews: PreviewProvider {
    static var previews: some View {
        OrderAccpetView()
    }
}

struct RoundButton: View {
    var title: String
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .cornerRadius(10)
        }
        .padding(.horizontal, 20)
    }
}
extension CGFloat {
    static var screenWidth: CGFloat {
        UIScreen.main.bounds.width
    }
    
    static var screenHeight: CGFloat {
        UIScreen.main.bounds.height
    }
}

extension EdgeInsets {
    static var bottomInsets: CGFloat {
        UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0
    }
}
