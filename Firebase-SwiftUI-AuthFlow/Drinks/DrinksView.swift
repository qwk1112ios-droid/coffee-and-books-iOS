//
//  DrinksView.swift
//  Firebase-SwiftUI-AuthFlow
//
//  Created by Amel Sbaihi on 4/29/26.
//

import SwiftUI

struct DrinksView: View {
    @State private var isFloating = false
    @State private var isPulsing = false

    var body: some View {
        ZStack {
            FluidModernBackground()
                .ignoresSafeArea()

            VStack(spacing: 22) {
                ZStack {
                    Circle()
                        .fill(.white.opacity(0.35))
                        .frame(width: 150, height: 150)
                        .scaleEffect(isPulsing ? 1.08 : 0.95)
                        .animation(
                            .easeInOut(duration: 1.8).repeatForever(autoreverses: true),
                            value: isPulsing
                        )

                    Image(systemName: "cup.and.saucer.fill")
                        .font(.system(size: 76))
                        .foregroundStyle(.purple.opacity(0.75))
                        .offset(y: isFloating ? -8 : 8)
                        .animation(
                            .easeInOut(duration: 1.4).repeatForever(autoreverses: true),
                            value: isFloating
                        )
                }

                VStack(spacing: 8) {
                    Text("Drinks are coming soon")
                        .font(.title2.weight(.bold))
                        .foregroundStyle(.primary)

                    Text("Refreshing juices, iced drinks, and cozy café beverages are on the way.")
                        .font(.subheadline)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.secondary)
                        .padding(.horizontal, 28)
                }

                HStack(spacing: 28) {
                    Image(systemName: "cup.and.saucer")
                    Image(systemName: "drop.fill")
                    Image(systemName: "takeoutbag.and.cup.and.straw.fill")
                }
                .font(.title)
                .foregroundStyle(.gray.opacity(0.75))
                .padding(.top, 4)
            }
            .padding(28)
            .frame(maxWidth: .infinity)
            .background(.white.opacity(0.45))
            .clipShape(RoundedRectangle(cornerRadius: 28, style: .continuous))
            .shadow(color: .black.opacity(0.08), radius: 18, x: 0, y: 10)
            .padding(.horizontal, 24)
        }
        .onAppear {
            isFloating = true
            isPulsing = true
        }
    }
}

#Preview {
    DrinksView()
}
