//
//  PaymentViewModel.swift
//  Firebase-SwiftUI-AuthFlow
//
//  Created by Amel Sbaihi on 6/23/26.
//

import Foundation
import StripePaymentSheet
import SwiftUI

@Observable

class PaymentViewModel {
   
    let service: PaymentServiceProtocol
    var successMessage : String = ""
    var errorMessage : String?
    var isLoading : Bool = false
    var paymentSheet: PaymentSheet?
    
    init(service: PaymentServiceProtocol = PaymentService()) {
        self.service = service
    }
    
    //MARK: - Stripe service payment
    
    func pay(amount: Int) async throws {
      isLoading =  true
      errorMessage = nil
        do {
            let clientSecret = try await service.startPayment(amount: amount).clientSecret
            var configuration = PaymentSheet.Configuration()
           configuration.merchantDisplayName = "Coffee & Books"
           paymentSheet = PaymentSheet(
                           paymentIntentClientSecret: clientSecret,
                           configuration: configuration
                       )
           successMessage = "Payment Sheet Ready \(clientSecret)"
           print("******* Success Message**********")
        }
        catch {
            let error = error.localizedDescription
            errorMessage = error
        }
        isLoading = false
    }
    
}
