//
//  AddProductScreen.swift
//  Swipe-Task
//
//  Created by Lakshay Gupta on 02/12/24.
//
import SwiftUI
import PhotosUI
struct AddProductScreen: View {
    @Environment(\.presentationMode) var presentationMode


    @StateObject private var viewModel = ProductAddViewModel()
    @State private var showImagePicker = false

    var body: some View {
        NavigationStack{
            Form {
                Section(header: Text("Product Details")) {
                    TextField("Product Name", text: $viewModel.productName)
                    TextField("Price", text: $viewModel.price)
                        .keyboardType(.decimalPad)
                    TextField("Tax", text: $viewModel.tax)
                        .keyboardType(.decimalPad)
                    Picker("Product Type", selection: $viewModel.productType) {
                        Text("Electronics").tag("Electronics")
                        Text("Clothing").tag("Clothing")
                        Text("Accessories").tag("Accessories")
                    }
                    Button("Select Image") {
                        showImagePicker = true
                    }
                    if let image = viewModel.image {
                        Image(uiImage: image)
                            .resizable()
                            .frame(width: 100, height: 100)
                            .scaledToFit()
                    }
                }
                
                Button(
                    
                    action : {
                        viewModel.saveProduct()
                    }
                ) {
                    Text("save product")
                }
                .disabled(viewModel.productName.isEmpty || viewModel.price.isEmpty || viewModel.isLoading||viewModel.tax.isEmpty)
                
                
                if viewModel.isErrorToast, let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                }
                
            }
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(selectedImage: $viewModel.image)
        }
        
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(

            leading:
                Button(action : { self.presentationMode.wrappedValue.dismiss() }){
                    Text("Cancel")
                }
            )

    }
}


#Preview{
    AddProductScreen()
        
}
