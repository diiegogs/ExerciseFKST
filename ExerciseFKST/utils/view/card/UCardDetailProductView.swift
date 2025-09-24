//
//  UCardDetailProductView.swift
//  ExerciseFKST
//
//  Created by Juan Diego Garcia Serrano on 23/09/25.
//

import SwiftUI

struct UCardDetailProductView: View {
    @Binding internal var isFavorite: Bool
    
    internal var name: String
    internal var price: Double
    internal var showDescription: Bool? = false
    internal var description: String?
    internal var image: String?
    internal var rating: Rating?
    internal var actionProduct: (() -> Void)?
    internal var actionFavorite: (() -> Void)?
    
    init(isFavorite: Binding<Bool>,
         name: String, price: Double,
         showDescription: Bool? = nil,
         description: String? = nil,
         image: String? = nil,
         rating: Rating? = nil,
         actionProduct: (() -> Void)? = nil,
         actionFavorite: (() -> Void)? = nil) {
        self._isFavorite = isFavorite
            self.name = name
            self.price = price
            self.showDescription = showDescription
            self.description = description
            self.image = image
            self.rating = rating
            self.actionProduct = actionProduct
            self.actionFavorite = actionFavorite
    }
    
    var body: some View {
        ZStack {
            Button {
                self.actionProduct?()
            } label: {
                ZStack {
                    if showDescription == false {
                        Color.white
                            .cornerRadius(10.0)
                            .shadow(color: .gray.opacity(0.8), radius: 10.0, x: 2.0, y: 2.0)
                    }
                    
                    VStack(spacing: 0.0) {
                        AsyncImage(url: URL(string: image ?? "")) { phase in
                            if let img = phase.image {
                                img
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 80.0, height: 80.0)
                            } else if let _ = phase.error {
                                Image(systemName: "photo")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 80.0, height: 80.0)
                                    .foregroundStyle(.gray.opacity(0.8))
                                    .padding()
                            } else {
                                ProgressView()
                                    .scaledToFit()
                                    .frame(width: 100.0, height: 100.0)
                            }
                            
                            Text(name)
                                .font(.system(size: 12.0, weight: .bold, design: .default))
                                .foregroundStyle(.black)
                                .frame(maxWidth: .infinity, alignment: .center)
                            
                            
                            
                            Text(price, format: .currency(code: "MXN"))
                                .font(.system(size: 10.0, weight: .bold, design: .default))
                                .padding(.bottom, 8.0)
                            
                            if let showDescription, showDescription {
                                
                                if let description = description, !description.isEmpty {
                                    Text(description)
                                        .font(.system(size: 10.0, weight: .bold, design: .default))
                                        .foregroundStyle(.gray)
                                }
                                
                                if let rating = rating {
                                    Text(String("Disponibles: \(rating.count)"))
                                        .foregroundStyle(.black)
                                        .font(.system(size: 10.0, weight: .bold))
                                    
                                    UStarRatingView(rating: rating.rate)
                                        .frame(width: 15.0, height: 15.0)
                                }
                                
                                Button {
                                    self.isFavorite.toggle()
                                    actionFavorite?()
                                } label: {
                                    ZStack {
                                        Color.white.opacity(0.002)
                                        
                                        VStack {
                                            HStack {
                                                Text("Agregar a favoritos")
                                                
                                                Image(systemName: self.isFavorite ? "heart.fill" : "heart")
                                                    .frame(width: 8.0, height: 8.0)
                                                    .foregroundStyle(self.isFavorite ? .red : .gray)
                                            }
                                        }
                                    }
                                }
                                .buttonStyle(.plain)
                                .frame(maxWidth: .infinity)
                                .padding(.top)
                                .fixedSize()
                            }
                        }
                    }
                    .padding()
                }
                .padding()
            }
        }
    }
}
