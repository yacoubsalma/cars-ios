import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ViewModel()
    @State private var showSignup: Bool = false
    @State private var showMainPage: Bool = false
    @State private var showLoginPage: Bool = true
    @ObservedObject var locationManager = LocationManager.shared
    @State private var isFirstLaunch: Bool = UserDefaults.standard.bool(forKey: "HasLaunchedBefore") ? false : true
    @State private var showLaunchScreen = true // Track if it's the first launch


    
    var body: some View {
        NavigationStack {
            
           
            if let role = UserDefaults.standard.string(forKey: "role") {

                if viewModel.isAuthenticated {
                    if locationManager.userlocation == nil {
                        // Show the location request page
                        LocationRequest()
                            .onAppear {
                                // Trigger location request when user is authenticated
                                locationManager.requestLocation()
                            }
                    } else {
                        if role == "Mechanic" {
                            
                            NavigationLink(
                                
                                destination: MenuMechanic(showmainPage: $showMainPage),
                                isActive: $showMainPage,
                                label: {
                                    EmptyView() // Navigation trigger
                                }
                            )
                            .onAppear {
                                showMainPage = true // Trigger navigation to MainPage
                            }
                        }else {
                            NavigationLink(
                                
                                destination: menu(showmainPage: $showMainPage),
                                isActive: $showMainPage,
                                label: {
                                    EmptyView() // Navigation trigger
                                }
                            )
                            .onAppear {
                                showMainPage = true // Trigger navigation to MainPage
                            }
                        }
                    }
                }
                
            }else {
                    Login(showSignup: $showSignup, showMainPage: $showMainPage)
                        .navigationDestination(isPresented: $showSignup) {
                            SignUp(showSignup: $showSignup)
                        }
                        .navigationDestination(isPresented: $showMainPage) {
                            menu(showmainPage: $showMainPage)
                        }
                }
            
            
        }
        .overlay {
            if (!viewModel.isAuthenticated && !showMainPage ) {
                if #available(iOS 17, *) {
                    AnimatedImageView()
                        .animation(.smooth(duration: 0.45, extraBounce: 0), value: showSignup)
                } else {
                    AnimatedImageView()
                        .animation(.easeInOut(duration: 0.3), value: showSignup)
                }
            }
        }
        .onAppear {
            updateAuthenticationState()
        }
        .onChange(of: viewModel.isAuthenticated) { isAuthenticated in
            // Handle state change when user logs in
            if isAuthenticated && locationManager.userlocation == nil {
                // Trigger location update if not yet fetched
                locationManager.requestLocation()
            }
        }
        .environmentObject(viewModel)
    }
    
    private func updateAuthenticationState() {
        // Check if token exists in UserDefaults and update isAuthenticated
        if let _ = UserDefaults.standard.string(forKey: "authToken") {
            viewModel.isAuthenticated = true
            if let role = UserDefaults.standard.string(forKey: "role") {
                viewModel.userrole = "Mechanic"
            }
        } else {
            viewModel.isAuthenticated = false
        }
    }
    
    @ViewBuilder
    func CircleView() -> some View {
        Circle()
            .fill(.linearGradient(colors: [ .blue, .blue, .app], startPoint: .top, endPoint: .bottom))
            .frame(width: 200, height: 200)
            .offset(x: showSignup ? 90 : -90, y: -360)
            .blur(radius: 15)
            .hSpacing(showSignup ? .trailing : .leading)
            .vSpacing(.top)
    }
    
    @ViewBuilder
    func AnimatedImageView() -> some View {
        Image("voiture-de-muscle")
            .frame(width: 200, height: 200)
            .offset(x: showSignup ? 40 : -39, y: -340)
            .hSpacing(showSignup ? .trailing : .leading)
            .vSpacing(.top)
            .animation(.easeInOut(duration: 1), value: showSignup) // Match animation properties
    }
}
