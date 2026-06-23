//
//  PaymentService.swift
//  Firebase-SwiftUI-AuthFlow
//
//  Created by Amel Sbaihi on 5/19/26.
//

import Foundation
import FirebaseFunctions

struct PaymentIntentResponse {
    let clientSecret: String
    let publishableKey: String
}

protocol PaymentServiceProtocol {
    func startPayment (amount: Int) async throws -> PaymentIntentResponse
}

class PaymentService: PaymentServiceProtocol {
    let functions = Functions.functions()
    func startPayment(amount:Int) async throws -> PaymentIntentResponse {
        let result = try await functions
            .httpsCallable("createPaymentIntent")
            .call([
                "amount": amount,
                "currency": "usd"
            ])

        guard let data = result.data as? [String: Any],
              let clientSecret = data["paymentIntent"] as? String,
              let publishableKey = data["publishableKey"] as? String
        else {
            throw NSError(domain: "Cloud", code: 0)
        }

        return PaymentIntentResponse(
            clientSecret: clientSecret,
            publishableKey: publishableKey
        )
    }
}
