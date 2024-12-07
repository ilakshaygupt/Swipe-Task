//
//  CustomAsyncImage.swift
//  Swipe-Task
//
//  Created by Lakshay Gupta on 04/12/24.
//
import SwiftUI

struct CustomAsyncImage: View {
    let imageUrlString: String?
    let width: CGFloat
    let height: CGFloat
    
    init(
        imageUrlString: String?, 
        width: CGFloat = 50, 
        height: CGFloat = 50
    ) {
        self.imageUrlString = imageUrlString
        self.width = width
        self.height = height
    }
    
    var body: some View {
        AsyncImage(url: URL(string: imageUrlString ?? "")) { phase in
            switch phase {
            case .empty:
                placeholderImage
                    .foregroundColor(.gray)
                
            case .success(let image):
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: width, height: height)
                
            case .failure:
                placeholderImage
                    .foregroundColor(.red)
                
            @unknown default:
                EmptyView()
            }
        }
        .frame(width: width, height: height)
    }
    
    private var placeholderImage: some View {
        Image(systemName: "photo")
            .resizable()
            .frame(width: width, height: height)
    }
}
