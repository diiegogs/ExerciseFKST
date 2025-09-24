//
//  ListProductsViewModel.swift
//  ExerciseFKST
//
//  Created by Juan Diego Garcia Serrano on 23/09/25.
//

import Foundation

class ListProductViewModel: ObservableObject {
    @Published var selectedProduct: ProductsResponse? = nil
    
    internal var sharedUD: UserDefaultManager = UserDefaultManager.shared
    
    init() {()}
}
