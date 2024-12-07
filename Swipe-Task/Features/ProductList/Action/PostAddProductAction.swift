//
//  PostAddProductAction.swift
//  Swipe-Task
//
//  Created by Lakshay Gupta on 04/12/24.
//

import Foundation

import SwiftUI

struct PostAddProductAction {
    let path = "/add"
    let method: HTTPMethod = .post
    var parameters: AddProductRequest


    func call(
        completion: @escaping (AddProductResponse) -> Void,
        failure: @escaping (APIError) -> Void
    ) {
        FormApiRequest<AddProductRequest, AddProductResponse>.call(
            path: path,
            method: method,
            parameters: parameters
            )
        {
            data in
            if let response = try? JSONDecoder().decode(
                AddProductResponse.self,
                from: data
            ) {
                print(response)

                completion(response)
            } else {
                
                failure(.jsonDecoding)
            }
        } failure: { error in
            print(error)
            failure(error)
        }


        }

    }

