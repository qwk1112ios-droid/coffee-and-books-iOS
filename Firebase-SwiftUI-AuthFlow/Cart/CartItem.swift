//
//  CartItem.swift
//  Firebase-SwiftUI-AuthFlow
//
//  Created by Amel Sbaihi on 5/1/26.
//

import Foundation

struct CartItem : Identifiable {
    let id : String
    let product : Product
    var  quantity : Int
    
    var totalPrice : Double {
        Double(quantity) * product.price
    }
}
