//
//  AddProductResponse.swift
//  Swipe-Task
//
//  Created by Lakshay Gupta on 04/12/24.
//

import Foundation


struct AddProductResponse : Decodable {
    var message : String
    var product_details : AddProductRequest
    var product_id : Int
    var success : Bool


}



