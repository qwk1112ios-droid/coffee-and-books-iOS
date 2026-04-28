//
//  Categories.swift
//  Firebase-SwiftUI-AuthFlow
//
//  Created by Amel Sbaihi on 4/25/26.
//

import SwiftUI

struct Categories: View {
    @State var vm = CategoryViewModel(service: CategoryService())
    var body: some View {
        TabView {
            NavigationStack {
                ZStack {
               FluidModernBackground()
                        .ignoresSafeArea()

                    ScrollView {
                        LazyVStack(spacing: 16) {
                            ForEach(vm.categories) { category in
                                CategoryCard(category: category)
                                    .frame(maxWidth: .infinity)
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 24)
                        .padding(.bottom, 110)
                    }
                    .scrollIndicators(.hidden)
                }.task {
                    await vm.fetchCategories()
                }
            }
            .tabItem {
                Label("Menu", systemImage: "cup.and.saucer.fill")
            }
        }
    }
}

struct CategoryCard: View {
  
    let category : CategoryItem
    var body: some View {
        HStack(spacing: 20) {
            AsyncImage(url: URL(string: category.imageUrl)) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 112, height: 112)
            .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))

            Text(category.title)
                .font(.title3.weight(.bold))
                .foregroundStyle(.primary)

            Spacer()

            Image(systemName: "chevron.right")
                .font(.headline.weight(.semibold))
                .foregroundStyle(.purple.opacity(0.65))
                .frame(width: 38, height: 38)
                .background(.purple.opacity(0.10))
                .clipShape(Circle())
        }
        .padding(18)
        .frame(maxWidth: .infinity, minHeight: 150)
        .background(.white.opacity(0.55))
        .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
        .shadow(color: .black.opacity(0.06), radius: 14, x: 0, y: 8)
    }
}
#Preview {
    Categories()
}
