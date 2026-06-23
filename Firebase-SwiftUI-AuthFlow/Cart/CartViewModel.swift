//
//  CartViewModel.swift
//  Firebase-SwiftUI-AuthFlow
//
//  Created by Amel Sbaihi on 5/1/26.
//
import StripePaymentSheet
import Foundation
@Observable

final class CartViewModel {
    
    private(set) var items: [CartItem] = []
    let service: PaymentServiceProtocol
    var successMessage : String = ""
    var errorMessage : String?
    var isLoading : Bool = false
    var paymentSheet: PaymentSheet?
    
    
    
    var total : Double {
        items.reduce(0) { $0 + $1.totalPrice }
    }
    var totalAmountInCents: Int {
        Int((total * 100).rounded())
    }
    
    init(service: PaymentServiceProtocol = PaymentService()) {
        self.service = service
    }
    // add coffee product only for now ... then I will add a funciton for other items on the menu and books.
    
    func addProduct(_ product: Product) {
       if let index = items.firstIndex(where: { $0.product.id == product.id }) {
            items[index].quantity += 1
        }
        else {
            items.append(CartItem(id: product.unwrappedID, product: product, quantity: 1))
        }
    }
    
    func removeProduct(_ product: Product) {
        // loop over all the elemets of item and remove any time this condition is met
        items.removeAll(where: {
            $0.product.id == product.id
        })
    }
    
    func increaseCartItems(item: CartItem) {
        guard let index = items.firstIndex(where: { $0.id == item.id }) else { return }
        items[index].quantity += 1
    }
    
    func decreaseCartItem(_ item: CartItem) {
           guard let index = items.firstIndex(where: { $0.id == item.id }) else { return }

           if items[index].quantity > 1 {
               items[index].quantity -= 1
           } else {
               items.remove(at: index)
           }
       }
    
    
    
    //MARK: - Stripe service payment
    
    func pay() async throws {
      isLoading =  true
      errorMessage = nil
        do {
            let clientSecret = try await service.startPayment(amount: totalAmountInCents).clientSecret
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

