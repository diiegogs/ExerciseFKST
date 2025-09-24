//
//  UStarView.swift
//  ExerciseFKST
//
//  Created by Juan Diego Garcia Serrano on 23/09/25.
//

import SwiftUI

struct UStarRatingView: View {
    var rating: Double = 0.0
    
    private func starFill(at index: Int) -> Double {
        let fullStar = Double(index) + 1
        if rating >= fullStar {
            return 1.0
        } else if rating + 1 > fullStar {
            return rating - Double(index)
        } else {
            return 0.0
        }
    }
    
    init(rating: Double) {
        self.rating = rating
    }
    
    var body: some View {
        HStack(spacing: 2.0) {
            ForEach(0...4, id: \.self) { index in
                UStarView(fillPercent: starFill(at: index))
                    .frame(width: 15, height: 15)
            }
        }
    }
}

struct UStarView: View {
    var fillPercent: Double
    
    var body: some View {
        ZStack {
            Image(systemName: "star")
                .resizable()
                .foregroundColor(.gray.opacity(0.3))
            GeometryReader { geo in
                Rectangle()
                    .fill(Color.yellow)
                    .frame(width: geo.size.width * fillPercent)
                    .mask(
                        Image(systemName: "star.fill")
                            .resizable()
                    )
            }
        }
    }
}
