//
//  UCardProductView.swift
//  ExerciseFKST
//
//  Created by Juan Diego Garcia Serrano on 23/09/25.
//

import SwiftUI

struct UCardProductView: View {
    internal var urlImageProduct: String
    internal var categoryProduct: String
    internal var actionProduct: (() -> Void)?
    
    init(urlImageProduct: String, categoryProduct: String, actionProduct: (() -> Void)? = nil) {
        self.urlImageProduct = urlImageProduct
        self.categoryProduct = categoryProduct
        self.actionProduct = actionProduct
    }
    
    var body: some View {
        ZStack {
            Button {
                self.actionProduct?()
            } label: {
                ZStack {
                    Color.white
                        .cornerRadius(10.0)
                        .shadow(color: .gray.opacity(0.8), radius: 10.0, x: 2.0, y: 2.0)
                    
                    VStack(spacing: 10.0) {
                        AsyncImage(url: URL(string: urlImageProduct)) { phase in
                            if let img = phase.image {
                                img
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100.0, height: 100.0)
                            } else if let _ = phase.error {
                                Image(systemName: "photo")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100.0, height: 100.0)
                                    .foregroundStyle(.gray.opacity(0.8))
                                    .padding()
                            } else {
                                ProgressView()
                                    .scaledToFit()
                                    .frame(width: 100.0, height: 100.0)
                            }
                        }
                        
                        VStack {
                            Text(categoryProduct)
                                .font(.system(size: 12.0, weight: .bold, design: .default))
                                .foregroundStyle(.black)
                        }
                    }
                    .padding()
                }
                .padding()
            }

        }
    }
}
