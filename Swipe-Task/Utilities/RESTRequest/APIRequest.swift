//
//  APIRequest.swift
//  Swipe-Task
//
//  Created by Lakshay Gupta on 01/12/24.
//



import Foundation

typealias CompletionHandler = (Data) -> Void
typealias FailureHandler = (APIError) -> Void

class APIRequest<Parameters: Encodable, Model: Decodable> {
    
    static func call(
        path: String,
        method: HTTPMethod,
        parameters: Parameters? = nil,
        headers: [String: String]? = nil,
        completion: @escaping CompletionHandler,
        failure: @escaping FailureHandler
    ) {
        
        let url = URL(string: "https://app.getswipe.in/api/public\(path)")
        var request = URLRequest(url: url!)
        request.httpMethod = method.rawValue
        
        headers?.forEach { key, value in
                    request.addValue(value, forHTTPHeaderField: key)
                }

        if let parameters = parameters {
            request.httpBody = try? JSONEncoder().encode(parameters)
        }

        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            if let data = data {
                
                completion(data)
                print(data)
            } else {
                if error != nil {
                    print(APIError.response)

                    failure(APIError.response)
                }
            }
        }
        task.resume()
    }
}
