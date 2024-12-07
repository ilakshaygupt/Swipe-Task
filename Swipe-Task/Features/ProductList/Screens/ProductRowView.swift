//
//  ProductRowView.swift
//  Swipe-Task
//
//  Created by Lakshay Gupta on 02/12/24.
//



import SwiftUI

struct ProductRowView: View {
     var product: ProductModel

    var body: some View {
        NavigationStack{
            HStack {
                CustomAsyncImage(imageUrlString: product.image)
                VStack(alignment: .leading) {
                    Text(product.productName)
                        .font(.headline)
                    Text("Type: \(product.productType ?? "Unknown")")
                        .font(.subheadline)
                    Text("Price: \(product.price, specifier: "%.2f")")
                        .font(.subheadline)
                    if let tax = product.tax {
                        Text("Tax: \(tax, specifier: "%.2f")%")
                            .font(.subheadline)
                    }
                }
                Spacer()
            }

            .padding()
        }
    }
}

