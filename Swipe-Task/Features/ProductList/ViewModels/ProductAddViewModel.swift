//
//  ProductAddViewModel.swift
//  Swipe-Task
//
//  Created by Lakshay Gupta on 04/12/24.
//

import Foundation
import SwiftUI


import Foundation
import UIKit
class ProductAddViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var success: Bool = false
    @Published var isErrorToast: Bool = false
    @Published var error: APIError?

    @Published var productName: String = ""
    @Published var productType: String = "Electronics"
    @Published var price: String = ""
    @Published var tax: String = ""
    @Published var image: UIImage?
    @Published var success_message : String = ""

    func validateFields() -> Bool {
        if productName.isEmpty {
            errorMessage = "Product name cannot be empty."
            isErrorToast = true
            return false
        }
        if Double(price) == nil {
            errorMessage = "Price must be a valid number."
            isErrorToast = true
            return false
        }
        if Double(tax) == nil {
            errorMessage = "Tax must be a valid number."
            isErrorToast = true
            return false
        }
        return true
    }
    func validateImage() -> Bool {
        guard let image = image else { return true }
        if let data = image.jpegData(compressionQuality: 1.0) ?? image.pngData(),
           UIImage(data: data) != nil {
            return image.size.width == image.size.height
        }
        errorMessage = "Invalid image format. Please upload JPEG or PNG in 1:1 ratio."
        isErrorToast = true
        return false
    }

    func saveProduct() {
        guard validateFields() else { return }

        self.error = nil
        self.isErrorToast = false
        self.errorMessage = ""
        self.isLoading = true



            PostAddProductAction(parameters: AddProductRequest(
                product_name: productName, product_type: productType, price: price, tax: tax, image: image
            )).call { response in
                DispatchQueue.main.async {
                    print(response.self.success)
                    print(self.success_message)

                    if response.success {
                        self.success = true
                        self.isLoading = false
                        self.success = true
                        self.isLoading = false
                        self.success_message = response.message
                        self.resetFields()

                    } else {
                        self.success = false
                        self.isErrorToast = true
                        self.isLoading = false
                    }
                }
            } failure: { error in
                DispatchQueue.main.async {
                    self.error = error
                    self.isLoading = false
                    self.isErrorToast =  true
                }
            }
    }

    private func resetFields() {
        self.productName = ""
        self.productType = "Electronics"
        self.price = ""
        self.tax = ""
        self.image = nil
    }
}
