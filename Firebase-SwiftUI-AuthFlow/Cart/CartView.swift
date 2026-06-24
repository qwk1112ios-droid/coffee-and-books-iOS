//
//  CartView.swift
//  Firebase-SwiftUI-AuthFlow
//
//  Created by Amel Sbaihi on 5/4/26.
//

import SwiftUI
import StripePaymentSheet

struct CartView: View {
    @Environment(CartViewModel.self) private var cart
    @State var paymentVM = PaymentViewModel()
    @State private var isPaymentSheetPresented = false
        var body: some View {
            List {
                ForEach(cart.items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.product.title)
                                .font(.headline)

                            Text("$\(item.totalPrice, specifier: "%.2f")")
                                .font(.subheadline)
                        }
                     Spacer()
                     HStack {
                            Button {
                                cart.decreaseCartItem(item)
                            } label: {
                                Image(systemName: "minus.circle")
                            }
                            .buttonStyle(.borderless)
                            Text("\(item.quantity)")
                                .font(.headline)
                            Button {
                                cart.increaseCartItems(item: item)
                            } label: {
                                Image(systemName: "plus.circle")
                            }
                            .buttonStyle(.borderless)
                        }
                    }
                }

                    HStack {
                    Text("Total")
                        .font(.headline)
                    Spacer()
                    Text("$\(cart.total, specifier: "%.2f")")
                        .font(.headline)
                }
                CheckoutButton{
                    Task{
                        try await paymentVM.pay(amount: cart.totalAmountInCents)
                        if paymentVM.paymentSheet != nil{
                            isPaymentSheetPresented = true
                        }
                        
                    }
                }
                Text(paymentVM.successMessage)

            }
            .navigationTitle("Cart")
            .paymentSheet(
                isPresented: $isPaymentSheetPresented,
                paymentSheet: paymentVM.paymentSheet ?? PaymentSheet(
                    paymentIntentClientSecret: "",
                    configuration: .init()
                )
            ) { result in
                switch result {
                case .completed:
                    paymentVM.successMessage = "Payment completed"
                case .canceled:
                    paymentVM.errorMessage = "Payment canceled"
                case .failed(let error):
                    paymentVM.errorMessage = error.localizedDescription
                }
            }
        }
    }


#Preview {
    CartView()
}

//MARK: - Checkout Button

struct CheckoutButton: View {
    @Environment(CartViewModel.self) private var cart
    let action: () -> Void

    var body: some View {
        Button {
           action()
          
        } label: {
            Text("Checkout")
                .foregroundColor(.white)
                
                .frame(maxWidth: .infinity)
                .background(.blue)
                 
        }
        .buttonStyle(.borderless)
        .disabled(cart.items.isEmpty)
    }
}
