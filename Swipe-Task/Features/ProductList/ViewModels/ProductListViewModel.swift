//
//  ProductListViewModel.swift
//  Swipe-Task
//
//  Created by Lakshay Gupta on 02/12/24.
//

import Foundation
import SwiftUI
import Foundation
import SwiftUI

class ProductListViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var productList: [ProductModel] = []
    @Published var errorMessage: String?
    @Published var progress: Double = 0.0
    
    @Published var searchText: String = ""
    @Published var filteredByFavorite: Bool = false
    
    var filteredProducts: [ProductModel] {
        productList
            .filter { product in
                let matchesSearch = self.searchText.isEmpty ||
                product.productName.localizedStandardContains(self.searchText)
                let matchesFavorite = !self.filteredByFavorite || product.isFavorite
                return matchesSearch && matchesFavorite
            }
            .sorted { (product1, product2) -> Bool in

                if product1.isFavorite != product2.isFavorite {
                    return product1.isFavorite && !product2.isFavorite
                }


                if product1.productName != product2.productName {
                    return product1.productName.localizedStandardCompare(product2.productName) == .orderedAscending
                }


                if let type1 = product1.productType, let type2 = product2.productType, type1 != type2 {
                    return type1.localizedStandardCompare(type2) == .orderedAscending
                }


                if product1.price != product2.price {
                    return product1.price < product2.price
                }

                return false
            }
    }

    

    private var filterPredicate: (ProductModel) -> Bool {
        { product in
            let matchesSearch = self.searchText.isEmpty || 
                product.productName.localizedStandardContains(self.searchText)
            let matchesFavorite = !self.filteredByFavorite || product.isFavorite
            return matchesSearch && matchesFavorite
        }
    }
    

    private var sortDescriptors: (ProductModel, ProductModel) -> Bool {
        { (product1, product2) -> Bool in

            if product1.isFavorite != product2.isFavorite {
                return product1.isFavorite && !product2.isFavorite
            }
            

            if product1.productName != product2.productName {
                return product1.productName.localizedStandardCompare(product2.productName) == .orderedAscending
            }
            

            if let type1 = product1.productType, let type2 = product2.productType, type1 != type2 {
                return type1.localizedStandardCompare(type2) == .orderedAscending
            }
            

            if product1.price != product2.price {
                return product1.price < product2.price
            }
            
            return false
        }
    }
    
    func fetchProductList() {
        self.isLoading = true
        
        GetProductListAction()
            .call {
                response in
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.productList = response.productList
                }
            } 
            failure: { error in
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                    self.isLoading = false
                }
            }
    }
    
    func toggleFavorite(for product: ProductModel) {
        guard let index = productList.firstIndex(where: { $0.id == product.id }) else { return }
        productList[index].isFavorite.toggle()
    }

    func toggleFavoriteFilter() {
        withAnimation {
            filteredByFavorite.toggle()
        }
    }
}
