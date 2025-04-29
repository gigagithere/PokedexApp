//
//  HeartButton.swift
//  PokedexApp
//
//  Created by Bartosz Mrugała on 29/04/2025.
//

import SwiftUI

struct HeartButton: View {
    @Binding var isLiked: Bool
    @State private var isAnimating = false

    var body: some View {
        Button(action: {
            isLiked.toggle()
            animateHeart()
        }) {
            Image(systemName: isLiked ? "heart.fill" : "heart")
                .scaleEffect(isAnimating ? 1.3 : 1.0)
                .foregroundColor(isLiked ? .red : .gray)
                .font(.title2)
        }
    }

    private func animateHeart() {
        withAnimation(.easeInOut(duration: 0.2)) {
            isAnimating = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            withAnimation(.easeInOut(duration: 0.2)) {
                isAnimating = false
            }
        }
    }
}

#Preview {
    PreviewWrapper()
}

private struct PreviewWrapper: View {
    @State private var isLiked = false

    var body: some View {
        HeartButton(isLiked: $isLiked)
    }
}
