//
//  AddProductRequest.swift
//  Swipe-Task
//
//  Created by Lakshay Gupta on 04/12/24.
//

import Foundation
import SwiftUI

struct AddProductRequest: Encodable , Decodable{
    var product_name: String
    var product_type: String
    var price: String
    var tax: String
    var image: String?

    init(product_name: String, product_type: String, price: String, tax: String, image: UIImage?) {
        self.product_name = product_name
        self.product_type = product_type
        self.price = price
        self.tax = tax

        if let image = image, let imageData = image.jpegData(compressionQuality: 0.8) {
            self.image = imageData.base64EncodedString()
        } else {
            self.image = nil
        }
    }
}
