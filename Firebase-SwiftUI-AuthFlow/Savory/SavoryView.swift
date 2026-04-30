//
//  SavoryView.swift
//  Firebase-SwiftUI-AuthFlow
//
//  Created by Amel Sbaihi on 4/29/26.
//

import SwiftUI

struct SavoryView: View {
    @State private var isFloating = false
    @State private var isPulsing = false

    var body: some View {
        ZStack {
            FluidModernBackground()
                .ignoresSafeArea(edges: .all)

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
                        .foregroundStyle(.gray.opacity(0.75))
                        .offset(y: isFloating ? -8 : 8)
                        .animation(
                            .easeInOut(duration: 1.6).repeatForever(autoreverses: true),
                            value: isFloating
                        )
                }

                VStack(spacing: 8) {
                    Text("Savory is coming soon")
                        .font(.title2.weight(.bold))
                        .foregroundStyle(.primary)

                    Text("Fresh bagels, light sandwiches, avocado bites, and cozy café favorites are on the way.")
                        .font(.subheadline)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.secondary)
                        .padding(.horizontal, 28)
                }

                HStack(spacing: 28) {
                    Image(systemName: "fork.knife")
                    Image(systemName: "leaf.fill")
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
    SavoryView()
}
