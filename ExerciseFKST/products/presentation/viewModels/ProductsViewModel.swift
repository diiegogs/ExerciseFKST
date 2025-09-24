//
//  ProductsViewModel.swift
//  ExerciseFKST
//
//  Created by Juan Diego Garcia Serrano on 23/09/25.
//

import Foundation

public class ProductsViewModel: ObservableObject {
    @Published internal var showLottie: Bool = false
    @Published internal var goToProductList: Bool = false
    @Published internal var groupProduct: [Category: [ProductsResponse]] = [:]
    @Published internal var productSelected: [ProductsResponse] = []
    
    internal let sharedUD: UserDefaultManager = UserDefaultManager.shared
    private var shared: UServiceManager = UServiceManager.shared
    
    // -MARK: Controlar persistencia 'desinstalar app' de UIApplicationDelegate para remover data de UserDefaults.
    
    internal func getProductsService() -> Void {
        
        if let products = sharedUD.loadObject(withKey: "products", type: [Category: [ProductsResponse]].self) , !products.isEmpty {
            self.groupProduct = products
        } else {
            DispatchQueue.main.async {
                self.showLottie = true
                self.shared.callService(url: "products") { [weak self] (response: [ProductsResponse]?) in
                    if let productsData = response, productsData.isEmpty == false {
                        // MARK: Saving images and using them with the Image component - ¡Important!
                        self?.groupProduct = Dictionary(grouping: productsData, by: { $0.category })
                        self?.sharedUD.saveObject(withKey: "products", value: self?.groupProduct)
                    } else {
                        if let savedProducts = UserDefaultManager.shared.loadObject(
                            withKey: "products",
                            type: [Category: [ProductsResponse]].self
                        ), savedProducts.isEmpty {
                            self?.groupProduct = [:]
                        }
                    }
                    self?.showLottie = false
                } failure: { [weak self] error in
                    self?.showLottie = false
                }
            }
        }
    }
    
}
