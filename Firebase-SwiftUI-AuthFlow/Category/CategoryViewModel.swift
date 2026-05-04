//
//  CategoryViewModel.swift
//  Firebase-SwiftUI-AuthFlow
//
//  Created by Amel Sbaihi on 4/26/26.
//

import Foundation

@MainActor

@Observable
class CategoryViewModel {
    var categories : [CategoryItem] = []
    var isLoading : Bool = false
    var errorMessage : String? = nil
    
    private let service : CategoryServiceProtocol
    
   
    var isEmpty: Bool {
        !isLoading && errorMessage == nil && categories.isEmpty
    }
    
    init(service: CategoryServiceProtocol) {
        self.service = service
    }
    func fetchCategories() async {

            isLoading = true

            errorMessage = nil

            do {

                categories = try await service.fetchCategory()

            } catch {

                errorMessage = "Unable to load categories. Please try again."
                print (error.localizedDescription)

            }

            isLoading = false

        }
}
