//
//  ProductsScreen.swift
//  ExerciseFKST
//
//  Created by Juan Diego Garcia Serrano on 23/09/25.
//

import SwiftUI

struct ProductsScreen: View {
    @StateObject private var viewModel: ProductsViewModel = ProductsViewModel()
    
    var body: some View {
        
        NavigationStack {
            GeometryReader { geo in
                VStack {
                    if viewModel.groupProduct.isEmpty {
                        VStack {
                            Image(systemName: "doc.plaintext")
                                .resizable()
                                .scaledToFit()
                                .foregroundStyle(.gray)
                                .frame(width: geo.size.width * 0.4, height: geo.size.height / 3)
                        }
                        .frame(width: geo.size.width, height: geo.size.height)
                    } else {
                        LazyVGrid(
                            columns: [
                                GridItem(.adaptive(minimum: 150.0))
                            ],
                            spacing: 10.0
                        ) {
                            ForEach(viewModel.groupProduct.keys.sorted(by: { $0.rawValue < $1.rawValue }), id: \.self) { category in
                                if let firstProduct = viewModel.groupProduct[category]?.first {
                                    UCardProductView(
                                        urlImageProduct: firstProduct.image,
                                        categoryProduct: category.rawValue
                                    ) {
                                        viewModel.productSelected = viewModel.groupProduct[category] ?? []
                                        viewModel.goToProductList = true
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .navigationBarHidden(true)
            .ignoresSafeArea(.all, edges: .bottom)
            .onAppear { [weak viewModel] in
                viewModel?.getProductsService()
            }
            .fullScreenCover(isPresented: $viewModel.showLottie) {
                ProgressView("...")
                    .progressViewStyle(.circular)
            }
            .navigationDestination(isPresented: $viewModel.goToProductList) {
                ListProductsScreen(productListSelected: $viewModel.productSelected)
            }
        }
    }
}
