//
//  FormApiRequest.swift
//  Swipe-Task
//
//  Created by Lakshay Gupta on 04/12/24.
//

import Foundation
import Foundation
import UIKit

class FormApiRequest<Parameters: Encodable, Model: Decodable> {

    static func call(
        path: String,
        method: HTTPMethod,
        parameters: Parameters? = nil,
        image: UIImage? = nil,
        headers: [String: String]? = nil,
        completion: @escaping CompletionHandler,
        failure: @escaping FailureHandler
    ) {
        let url = URL(string: "https://app.getswipe.in/api/public\(path)")!
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue

        let boundary = "Boundary-\(UUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        var body = Data()

        if let parameters = parameters {
            let mirror = Mirror(reflecting: parameters)
            for child in mirror.children {
                if let label = child.label, let value = child.value as? String {
                    body.append("--\(boundary)\r\n".data(using: .utf8)!)
                    body.append("Content-Disposition: form-data; name=\"\(label)\"\r\n\r\n".data(using: .utf8)!)
                    body.append("\(value)\r\n".data(using: .utf8)!)
                }
            }
        }

        // Add image if present
        if let image = image, let imageData = image.jpegData(compressionQuality: 0.8) {
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"files[]\"; filename=\"image.jpg\"\r\n".data(using: .utf8)!)
            body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
            body.append(imageData)
            body.append("\r\n".data(using: .utf8)!)
        }

        body.append("--\(boundary)--\r\n".data(using: .utf8)!)

        request.httpBody = body

        
        headers?.forEach { key, value in
            request.addValue(value, forHTTPHeaderField: key)
        }

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                failure(.response)
                return
            }

            guard let data = data else {
                failure(.response)
                return
            }

            completion(data)
        }
        task.resume()
    }
}
