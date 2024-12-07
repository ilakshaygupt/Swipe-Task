//
//  ProductListScreen.swift
//  Swipe-Task
//
//  Created by Lakshay Gupta on 02/12/24.
//

import SwiftUI

struct ProductListScreen: View {
    @StateObject private var productListViewModel = ProductListViewModel()

    var body: some View {
        NavigationStack {
            VStack {
                if productListViewModel.isLoading {
                    ProgressView("Loading Products...")
                } else if let errorMessage = productListViewModel.errorMessage {
                    Text("Error: \(errorMessage)")
                        .foregroundColor(.red)
                } else {
                    SearchBar(text: $productListViewModel.searchText)
                    List(productListViewModel.filteredProducts) { product in
                        HStack {
                            ProductRowView(product: product)
                            Spacer()

                            Button(action: {
                                withAnimation(.spring(response: 0.5, dampingFraction: 0.7, blendDuration: 0.3)) {
                                    productListViewModel.toggleFavorite(for: product)
                                }
                            }) {
                                if product.isFavorite {
                                    Image(systemName: "heart.fill")
                                        .foregroundStyle(.red)
                                } else {
                                    Image(systemName: "heart")
                                }
                            }
                        }
                        .transition(.asymmetric(insertion: .move(edge: .top), removal: .opacity))
                    }
                    .refreshable {
                        productListViewModel.fetchProductList()
                    }
                    .animation(.spring(duration: 0.5), value: productListViewModel.searchText)

                }
            }
            .navigationTitle("Products")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink(destination: AddProductScreen()) {
                        Text("Add Product")
                    }
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button(productListViewModel.filteredByFavorite ? "Show All" : "Filter Favorites") {
                        productListViewModel.toggleFavoriteFilter()
                    }
                    .tint(productListViewModel.filteredByFavorite ? .red : .blue)
                }
            }
        }
        .onAppear {
            productListViewModel.fetchProductList()
        }
    }
}

#Preview {
    ProductListScreen()
}
