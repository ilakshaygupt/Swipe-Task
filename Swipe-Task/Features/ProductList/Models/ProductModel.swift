//
//  ProductModel.swift
//  Swipe-Task
//
//  Created by Lakshay Gupta on 02/12/24.
//

import Foundation


struct ProductModel: Decodable, Hashable , Identifiable {
    var id: UUID = UUID()
    var image: String?
    var price: Double
    var productName: String
    var productType: String?
    var tax: Double?
    var isFavorite: Bool = false


    enum CodingKeys: String, CodingKey {
        case image
        case price
        case productName = "product_name"
        case productType = "product_type"
        case tax
    }


    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.image = try container.decodeIfPresent(String.self, forKey: .image)
        self.price = try container.decode(Double.self, forKey: .price)
        self.productName = try container.decode(String.self, forKey: .productName)
        self.productType = try container.decodeIfPresent(String.self, forKey: .productType)
        self.tax = try container.decodeIfPresent(Double.self, forKey: .tax)
        self.id = UUID()
        self.isFavorite = false
    }

}

