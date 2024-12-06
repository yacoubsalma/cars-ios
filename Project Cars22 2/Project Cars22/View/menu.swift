//
//  menu.swift
//  Project Cars22
//
//  Created by Abderrahmen on 28/11/2024.
//

import SwiftUI

struct menu: View {
    @Binding var showmainPage: Bool

    @State private var isConnected = false // Change this based on car detail availability
    @State private var carDetails: [CarDetail] = [] // List of car details
    @State private var showCarDetailView = false // Controls whether the car detail sheet is shown

    @State private var vin: String = "" // State variable to hold user input
        @State private var errorMessage: String? // To display API response
        @State private var isLoading: Bool = false
    var body: some View {
        ZStack {
            
            Image("fond2")
                .resizable()             // Make the image resizable
                .scaledToFill()          // Fill the screen with the image, cropping if necessary
                .ignoresSafeArea()
            
            ScrollView {
                VStack {
                    Text("Smart \n  Car scaner ")
                        .font(.system(size: 50, weight: .bold)) // Make text larger and bold
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity)
                        .padding(.top, 50) // Add padding to move
                    
                    Image("blackcar1") // Replace with your image name
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200) // Adjust the
                    
                    ZStack {
                                // Box background
                        Color(.systemGray4).opacity(0.2) // Grey with a subtle hint of blue and semi-transparency
                                               .cornerRadius(25) // Rounded corners
                                               .frame(height: 70)
                                               .padding(.horizontal, 20)

                                // Box content
                                HStack {
                                    // Connection status text
                                    VStack(alignment: .leading) {
                                        Text(isConnected ? "Connected" : "Please connect Your car")


                                            .font(.headline)
                                            .bold()
                                            .foregroundColor(isConnected ? .green : .red) // Dynamic color
                                            .padding(.bottom, 5)
                                            .padding(.horizontal, 25)


                                       
                                    }

                                    Spacer() // Push the arrow to the right

                                    if !isConnected {
                                              NavigationLink(destination: carvinView(isConnected: $isConnected, carDetails: $carDetails)) {
                                                  Image(systemName: "chevron.right")
                                                      .foregroundColor(.white)
                                                      .padding()
                                              }
                                          }
                                }
                                .padding(.horizontal, 20)
                            }
                            .padding(.top, 30) // Add space between image and box
                    HStack {
                        ZStack {
                            Color(.systemGray4).opacity(0.2) // Grey with a subtle hint of blue and semi-transparency
                                                   .cornerRadius(25) // Rounded corners
                                                   .frame(height: 170)
                                                   .padding(.horizontal, 10)
                            
                         

                                    // Box content
                                    HStack {
                                        // Deatils car
                                        VStack(alignment: .leading) {
                                            Text("Details about your car")
                                                .font(.headline)
                                                .bold()
                                                .multilineTextAlignment(.center) // Center text horizontally

                                                .foregroundColor(.white) // Dynamic color
                                                .padding(.bottom, 5)
                                                .padding(.horizontal, 10)
                                                .onTapGesture {
                                                                           // Show car detail view when tapped
                                                                           showCarDetailView = true
                                                                       }

                                            if !isConnected {
                                               
                                            }
                                        }

                                        Spacer() // Push the arrow to the right

                                       
                                    }
                                    .padding(.horizontal, 20)
                            
                                }
                        .padding(.top, 30)
                        ZStack {
                                    // Box background
                            Color(.systemGray4).opacity(0.2) // Grey with a subtle hint of blue and semi-transparency
                                                   .cornerRadius(25) // Rounded corners
                                                   .frame(height: 170)
                                                   .padding(.horizontal, 10)

                                    // Box content
                                    HStack {
                                        // Connection status text
                                        VStack(alignment: .leading) {
                                            Text("Contact Mechanical")
                                                .font(.headline)
                                                .bold()
                                                .foregroundColor(.white) // Dynamic color
                                                .padding(.bottom, 5)
                                                .padding(.horizontal, 25)
                                                .multilineTextAlignment(.center) // Center text horizontally


                                            if !isConnected {
                                               
                                            }
                                        }

                                        Spacer() // Push the arrow to the right

                                       
                                    }
                                    .padding(.horizontal, 20)
                                }
                        .padding(.top, 30)
                        
                    } // Add space between image
                    HStack {
                        ZStack {
                            Color(.systemGray4).opacity(0.2) // Grey with a subtle hint of blue and semi-transparency
                                                   .cornerRadius(25) // Rounded corners
                                                   .frame(height: 170)
                                                   .padding(.horizontal, 10)
                            
                         

                                    // Box content
                            NavigationLink (destination: ViewMap()) {
                                HStack {
                                            // Deatils car
                                            VStack(alignment: .leading) {
                                                Text("Map")
                                                    .font(.headline)
                                                    .bold()
                                                    .multilineTextAlignment(.center) // Center text horizontally

                                                    .foregroundColor(.white) // Dynamic color
                                                    .padding(.bottom, 5)
                                                    .padding(.horizontal, 50)

                                                if !isConnected {
                                                   
                                                }
                                            }

                                            Spacer() // Push the arrow to the right

                                           
                                        }
                                .padding(.horizontal, 20)
                            }
                            
                                }
                        .padding(.top, 30)
                        ZStack {
                                    // Box background
                            Color(.systemGray4).opacity(0.2) // Grey with a subtle hint of blue and semi-transparency
                                                   .cornerRadius(25) // Rounded corners
                                                   .frame(height: 170)
                                                   .padding(.horizontal, 10)

                                    // Box content
                            NavigationLink(destination: NewsFeedView()) {
                                HStack {
                                            // Connection status text
                                            VStack(alignment: .leading) {
                                                Text("News")
                                                    .font(.headline)
                                                    .bold()
                                                    .foregroundColor(.white) // Dynamic color
                                                    .padding(.bottom, 5)
                                                    .padding(.horizontal, 25)
                                                    .multilineTextAlignment(.center) // Center text horizontally


                                                if !isConnected {
                                                   
                                                }
                                            }

                                            Spacer() // Push the arrow to the right

                                           
                                        }
                                .padding(.horizontal, 20)
                            }
                                }
                        .padding(.top, 30)
                        
                    } // Add space between image
                    

                            Spacer() // Push everything up
                }
            }

                }
//        .navigationBarTitle("Menu", displayMode: .inline)
        .navigationBarBackButtonHidden(true) // This hides the back button
        .sheet(isPresented: $showCarDetailView) {
            carDetailsview(carDetails: $carDetails)
                    }

                .onTapGesture {
                    // Handle tap to navigate or show VIN input screen
                    if !isConnected {
                        print("Navigate to VIN input screen")
                    }
                }
            }
    
    
    
    
    
    
    func decodeVIN(vin: String) {
        guard !vin.isEmpty else { return }

        isLoading = true
        errorMessage = nil
        carDetails = []

        let headers = [
            "x-rapidapi-key": "40749a7270msh4b1b60b2bcf3203p156369jsn83c66b79b545",
             "x-rapidapi-hos": "vin-decoder-europe2.p.rapidapi.com"
        ]

        guard let url = URL(string: "https://vin-decoder-europe2.p.rapidapi.com/vin_decoder?vin=\(vin)") else {
                   errorMessage = "Invalid URL."
                   isLoading = false
                   return
               }

        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                isLoading = false


                guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                    errorMessage = "Invalid Response."

                    return
                }

                if let data = data, let jsonResponse = String(data: data, encoding: .utf8) {
                    do {
                                      // Decode the JSON response
                                      if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                                          carDetails = json.map { CarDetail(name: $0.key, result: "\($0.value)") }
                                      } else {
                                          errorMessage = "Invalid response format."
                                      }
                                  } catch {
                                      errorMessage = "Failed to decode JSON: \(error.localizedDescription)"
                                  }
                } else {
                    errorMessage = "Failed to decode response."
                }
            }
        }

        dataTask.resume()
    }
    }
    
    






#Preview {
    ContentView()
}
