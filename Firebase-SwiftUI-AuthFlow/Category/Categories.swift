//
//  Categories.swift
//  Firebase-SwiftUI-AuthFlow
//
//  Created by Amel Sbaihi on 4/25/26.
//


import SwiftUI

extension Color {
    static let coffeePrimary = Color(red: 0.32, green: 0.24, blue: 0.20)
    static let coffeeSecondary = Color(red: 0.55, green: 0.48, blue: 0.44)
}

struct Categories: View {
    @State var vm = CategoryViewModel(service: CategoryService())
    var body: some View {
        TabView {
            NavigationStack {
                ZStack {
               FluidModernBackground()
                        .ignoresSafeArea()

                    ScrollView {
                        VStack(alignment: .leading, spacing: 8) {
                            HStack() {
                                Text("Good evening")
                                    .font(.largeTitle.weight(.bold))
                                    .foregroundStyle(Color.coffeePrimary)

                                Image("icn4")
                                    .resizable()
                                    .scaledToFill()
                                    .font(Font.largeTitle.weight(.bold))
                                    .frame(width: 50, height: 50)
                                    .offset(y: -2)
                            }

                            Text("What are you in the mood for? ")
                                .font(.title3)
                                .foregroundStyle(Color.coffeeSecondary)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 24)
                        .padding(.top, 28)
                        .padding(.bottom, 8)

                        LazyVStack(spacing: 18) {
                            ForEach(vm.categories) { category in
                                NavigationLink {
                                    destinationView(for: category.destination)
                                } label: {
                                    CategoryCard(category: category)
                                        .frame(maxWidth: .infinity)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 8)
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
            
            NavigationStack {
                ZStack {
                    FluidModernBackground()
                        .ignoresSafeArea()

                    BookView()
                }
            }
            .background(Color.clear)
            .toolbarBackground(.hidden, for: .navigationBar)
            .toolbarBackground(.hidden, for: .tabBar)
            .tabItem {
                Label("Shop", systemImage: "book.fill")
            }
            
            NavigationStack {
                ZStack {
                    FluidModernBackground()
                        .ignoresSafeArea()

                    InfoSetting()
                }
            }
            .background(Color.clear)
            .toolbarBackground(.hidden, for: .navigationBar)
            .toolbarBackground(.hidden, for: .tabBar)
            .tabItem {
                Label("Settings", systemImage: "person.crop.circle")
            }
        }
    }
    
    @ViewBuilder
       private func destinationView(for destination: CategoryDestination) -> some View {
           switch destination {
           case .coffee:
               ProductView()
           case .drinks:
               DrinksView()
           case .savory:
               SavoryView()
           case .bakery:
               BakeryView()
              
           }
       }
   }



struct CategoryCard: View {
    let category: CategoryItem

    private var iconName: String {
        switch category.destination {
        case .coffee:
            return "cb2"
        case .drinks:
            return "soda"
        case .savory:
            return "sandwich"
        case .bakery:
            return "croissant"
        }
    }

    private var subtitle: String {
        switch category.destination {
        case .coffee:
            return "Hot & cold coffee for every mood"
        case .drinks:
            return "Refreshing drinks to brighten your day"
        case .savory:
            return "Fresh, tasty bites made to delight"
        case .bakery:
            return "Sweet treats baked fresh daily"
        }
    }

    private var accentColor: Color {
        switch category.destination {
        case .coffee:
            return .brown
        case .drinks:
            return Color.drinksAccent
        case .savory:
            return Color.savoryGreen
        case .bakery:
            return .brown
        }
    }

    var body: some View {
        HStack(spacing: 18) {
            ZStack(alignment: .bottomTrailing) {
                AsyncImage(url: URL(string: category.imageUrl)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .frame(width: 118, height: 118)
                .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))

                Image(systemName: "heart")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(.white)
                    .padding(8)
            }

            VStack(alignment: .leading, spacing: 10) {
                Image(iconName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .foregroundStyle(accentColor)
                    .frame(width: 42, height: 42)
                    .background(accentColor.opacity(0.12))
                    .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))

                Text(category.title)
                    .font(.title2.weight(.bold))
                    .foregroundStyle(Color.coffeePrimary)
                Text(category.destination.rawValue)
                    .font(.caption)

                Text(subtitle)
                    .font(.subheadline)
                    .foregroundStyle(Color.coffeeSecondary)
                    .lineLimit(2)
            }

            Spacer(minLength: 8)

            Image(systemName: "chevron.right")
                .font(.headline.weight(.bold))
                .foregroundStyle(accentColor)
                .frame(width: 46, height: 46)
                .background(.white.opacity(0.45))
                .clipShape(Circle())
                .shadow(color: accentColor.opacity(0.18), radius: 8, x: 0, y: 4)
        }
        .padding(18)
        .frame(maxWidth: .infinity, minHeight: 168)
        .background(.ultraThinMaterial.opacity(0.85))
        .background(
            LinearGradient(
                colors: [
                    .white.opacity(0.55),
                    accentColor.opacity(0.08)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .clipShape(RoundedRectangle(cornerRadius: 28, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 28, style: .continuous)
                .stroke(.white.opacity(0.45), lineWidth: 1)
        )
        .shadow(color: .black.opacity(0.08), radius: 16, x: 0, y: 10)
    }
}
#Preview {
    Categories()
}
