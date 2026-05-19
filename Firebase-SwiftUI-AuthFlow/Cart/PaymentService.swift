//
//  PaymentService.swift
//  Firebase-SwiftUI-AuthFlow
//
//  Created by Amel Sbaihi on 5/19/26.
//

import Foundation
import FirebaseFunctions

protocol PaymentServiceProtocol {
    func startPayment () async throws -> String
}

class PaymentService: PaymentServiceProtocol {
    let functions = Functions.functions()
    func startPayment() async throws -> String {
        let result = try await functions.httpsCallable("createPaymentIntent").call()
        guard let data = result.data as? [String: Any], let message = data["message"] as? String else {
            throw NSError(domain: "Cloud", code: 0, userInfo: nil)
        }
        return message
    }
}
