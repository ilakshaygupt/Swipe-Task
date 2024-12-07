//
//  Swipe_TaskApp.swift
//  Swipe-Task
//
//  Created by Lakshay Gupta on 01/12/24.
//

import SwiftUI

@main
struct Swipe_TaskApp: App {
    @StateObject private var productListViewModel = ProductListViewModel()

    var body: some Scene {
        WindowGroup {
            ProductListScreen()
                .onAppear{
                    productListViewModel.fetchProductList()
                }
                
        }
    }
}
