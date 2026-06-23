//
//  Firebase_SwiftUI_AuthFlowApp.swift
//  Firebase-SwiftUI-AuthFlow
//
//  Created by Amel Sbaihi on 3/29/26.
//

import SwiftUI
import Firebase
import GoogleSignIn
import StripePaymentSheet

@main
struct Firebase_SwiftUI_AuthFlowApp: App {
    @State var authManager: AuthenticationManager
    @State private var cartViewModel:  CartViewModel
    init () {
        FirebaseApp.configure()
        if let clientID = FirebaseApp.app()?.options.clientID {
                    GIDSignIn.sharedInstance.configuration = GIDConfiguration(clientID: clientID)
                } else {
                    assertionFailure("Missing Firebase clientID. Check GoogleService-Info.plist target membership.")
                }
        StripeAPI.defaultPublishableKey = "pk_test_51TSKmwD0agb75Rps96S0YkxBHVyTTfzdU3GEa4Hi4I1rNkjsKW9Brk2w9HGzLsMAb0vtBfUVsVazBs8hpolDOviJ00ERayXfMg"
        _authManager = State(initialValue: AuthenticationManager())
        _cartViewModel = State(initialValue: CartViewModel())
    }
    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(authManager)
                .environment(cartViewModel)
            
        }
    }
}
