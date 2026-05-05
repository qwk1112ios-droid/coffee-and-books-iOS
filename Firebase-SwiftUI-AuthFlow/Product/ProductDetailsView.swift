//
//  ProductDetailsView.swift
//  Firebase-SwiftUI-AuthFlow
//
//  Created by Amel Sbaihi on 4/20/26.
//

import SwiftUI

struct ProductDetailsView: View {
   @Environment(CartViewModel.self) private var cart
    private var cartItem: CartItem? {
        cart.items.first { $0.product.id == product.id }
    }
    let product: Product
    var body: some View {

        HStack(spacing: 12) {
            AsyncImage(url: URL(string: product.imageUrl)) { image in
                            image
                                .resizable()
                                .scaledToFill()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 70, height: 70)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
            VStack(alignment: .leading, spacing: 4) {
                Text(product.title)
                    .font(.headline)
                Text(product.description)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                Text("$\(product.price, specifier: "%.2f")")
                    .font(.subheadline)
                    .fontWeight(.semibold)
            }

            Spacer()

            
            if let cartItem {
                HStack(spacing: 10) {
                    Button {
                        cart.decreaseCartItem(cartItem)
                    } label: {
                        Image(systemName: "minus.circle.fill")
                            .font(.title2)
                            .foregroundStyle(Color.drinksAccent)
                    }

                    Text("\(cartItem.quantity)")
                        .font(.headline)
                        .frame(minWidth: 24)

                    Button {
                        cart.increaseCartItems(item: cartItem)
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                            .foregroundStyle(Color.drinksAccent)
                    }
                }
            } else {
                Button {
                    cart.addProduct(product)
                } label: {
                    Image(systemName: "cart.badge.plus")
                        .font(.title2)
                        .foregroundStyle(Color.drinksAccent)
                    

                }
                .padding()
            }

        }

        .padding(.vertical, 4)

    }
}

#Preview {
    ProductDetailsView(
        product: Product(
            id: "fakeId",
            title: "product1",
            description: "dummyproduct",
            price: 2.99, 
            imageUrl: "ImageUrl.com"
        )
    )
}
