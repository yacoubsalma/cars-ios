
import SwiftUI
struct MenuMechanic: View {
    
    
    @Binding var showmainPage: Bool
    @EnvironmentObject var viewModel: ViewModel
    
    @State private var isConnected = false
    @State private var carDetails: [CarDetail] = []
    @State private var showCarDetailView = false
    @State private var vin: String = ""
    @State private var errorMessage: String?
    @State private var isLoading: Bool = false
    @State private var showMessages = false // Toggle for dropdown
    @State private var messages = [
        "Message 1: This is the first message.",
        "Message 2: This is the second message."
    ]
    @State private var bookings: [Booking] = []
    
    private var pendingMessagesCount: Int {
        bookings.filter { $0.etat == 0 }.count
    }// Replace messages with bookings
    
    
    var body: some View {
        ZStack {
            // Background
            Image("fond2")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack {
                // Top Bar
                HStack {
                    Spacer()
                    
                    // Message Icon
                    Button(action: {
                        withAnimation {
                            showMessages.toggle()
                        }
                    }) {
                        ZStack {
                            Image(systemName: "envelope.fill")
                                .resizable()
                                .frame(width: 30, height: 20)
                                .foregroundColor(.white)
                            
                            if pendingMessagesCount > 0 {
                                Text("\(pendingMessagesCount)")
                                    .font(.caption2)
                                    .bold()
                                    .foregroundColor(.white)
                                    .frame(width: 18, height: 18)
                                    .background(Color.red)
                                    .clipShape(Circle())
                                    .offset(x: 12, y: -8)
                            }
                        }
                    }
                    .padding()
                }
                .frame(maxWidth: .infinity, maxHeight: 50)
                .background(Color.black.opacity(0.5))
                
                // Main Content
                ScrollView {
                    VStack {
                        // Welcome Text
                        Text("Smart \n  Car scanner welcome ")
                            .font(.system(size: 50, weight: .bold))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity)
                            .padding(.top, 50)
                        
                        Image("blackcar1")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200)
                        
                        // Your existing car connection boxes and other UI
                        Spacer()
                    }
                }
                
                Spacer()
                
                // Bottom Bar
                HStack {
                    // Menu Icon
                    Button(action: {
                        print("Menu button tapped")
                    }) {
                        VStack {
                            Image(systemName: "list.dash")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.white)
                            Text("Menu")
                                .font(.caption)
                                .foregroundColor(.white)
                        }
                    }
                    .padding()
                    
                    Spacer()
                    
                    // Parameter Icon
                    Button(action: {
                        print("Parameters button tapped")
                    }) {
                        VStack {
                            Image(systemName: "gearshape.fill")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.white)
                            Text("Parameters")
                                .font(.caption)
                                .foregroundColor(.white)
                        }
                    }
                    .padding()
                }
                .frame(height: 80)
                .background(Color.black.opacity(0.8))
                .cornerRadius(15)
                .padding([.leading, .trailing], 20)
            }
            
            // Dropdown Messages
            if showMessages {
                VStack(alignment: .leading, spacing: 10) {
                    ForEach(bookings.filter { $0.etat == 0 }, id: \.id) { booking in
                        VStack(alignment: .leading) {
                            Text("Problem: \(booking.problem) with date \(booking.date) ")
                                .font(.subheadline)
                                .foregroundColor(.primary)
                                .padding(.bottom, 5)
                            
                            HStack {
                                Button(action: {
                                    print("Accepted message \(booking.id)")
                                    viewModel.updateBookingStatus(id: booking.id, newEtat: 1) // 1 represents accepted
                                                                             withAnimation {
                                                                                 // Hide the message after accepting
                                                                                 bookings.removeAll { $0.id == booking.id }
                                                                             }
                                }) {
                                    Text("Accept")
                                        .bold()
                                        .frame(maxWidth: .infinity)
                                        .padding()
                                        .background(Color.green.opacity(0.8))
                                        .foregroundColor(.white)
                                        .cornerRadius(8)
                                }
                                
                                Button(action: {
                                    print("Refused message \(booking.id)")
                                    viewModel.updateBookingStatus(id: booking.id, newEtat: 2) // 2 represents rejected
                                                                            withAnimation {
                                                                                // Hide the message after rejecting
                                                                                bookings.removeAll { $0.id == booking.id }
                                                                            }
                                }) {
                                    Text("Refuse")
                                        .bold()
                                        .frame(maxWidth: .infinity)
                                        .padding()
                                        .background(Color.red.opacity(0.8))
                                        .foregroundColor(.white)
                                        .cornerRadius(8)
                                }
                            }
                            .padding(.bottom, 5)
                        }
                        .padding()
                        .background(Color.white.opacity(0.9))
                        .cornerRadius(10)
                        .shadow(radius: 5)
                    }
                }
                .padding()
                .background(Color.black.opacity(0.3))
                .cornerRadius(12)
                .padding(.horizontal, 20)
                .frame(maxWidth: .infinity, alignment: .topTrailing)
                .offset(y: 80) // Adjust to place it below the icon
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            isLoading = true
            viewModel.Bookings() { isSuccess in
                DispatchQueue.main.async {
                    isLoading = false
                    if isSuccess! {
                        bookings = viewModel.bookings
                    } else {
                        errorMessage = "Failed to load bookings"
                    }
                }
            }
        }
    }
}
