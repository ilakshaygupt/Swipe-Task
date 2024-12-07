//
//  GetProductListAction.swift
//  Swipe-Task
//
//  Created by Lakshay Gupta on 02/12/24.
//


import Foundation

struct GetProductListAction {
    let path = "/get"
    let method: HTTPMethod = .get

       func call(
           completion: @escaping (SignupResponse) -> Void,
           failure: @escaping (APIError) -> Void
       ) {
           APIRequest<GetRequest, SignupResponse>.call(
               path: path,
               method: .get
           ) { data in
               do {
                   let products = try JSONDecoder().decode([ProductModel].self, from: data)
                   print("Successfully decoded products directly: \(products.count)")

                   let response = SignupResponse(productList: products)
                   completion(response)
               } catch {
                   print("Decoding Error: \(error)")
                   failure(.jsonDecoding)
               }
           } failure: { error in
               failure(error)
           }
       }
   }
