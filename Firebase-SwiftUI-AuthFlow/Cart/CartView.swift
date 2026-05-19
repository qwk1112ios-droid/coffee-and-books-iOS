//
//  CartView.swift
//  Firebase-SwiftUI-AuthFlow
//
//  Created by Amel Sbaihi on 5/4/26.
//

import SwiftUI

struct CartView: View {
    @Environment(CartViewModel.self) private var cart
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
                
                CheckoutButton()
                Text(cart.successMessage)

            }
            .navigationTitle("Cart")
        }
    }


#Preview {
    CartView()
}

struct CheckoutButton: View {
    @Environment(CartViewModel.self) private var cart

    var body: some View {
        Button {
            Task {
                 try await cart.pay()
            }
          
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
