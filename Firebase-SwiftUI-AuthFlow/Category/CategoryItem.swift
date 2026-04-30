//
//  CategoryItem.swift
//  Firebase-SwiftUI-AuthFlow
//
//  Created by Amel Sbaihi on 4/26/26.
//

import Foundation
import FirebaseFirestore

enum CategoryDestination : String , Codable{
    case coffee
    case savory
    case bakery
    case drinks 
}

struct CategoryItem : Identifiable , Codable{
    @DocumentID var id : String?
    let title: String
    let imageUrl: String
    let destination : CategoryDestination
}
