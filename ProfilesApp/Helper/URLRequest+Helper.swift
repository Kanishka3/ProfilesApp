//
//  URLRequest+Helper.swift
//  ProfilesApp
//
//  Created by Kanishka Chaudhry on 07/11/24.
//

import Foundation

extension URLRequest {
    mutating func setJSONBody(from parameters: [String: String]) {
        guard let jsonData = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        self.httpBody = jsonData
        self.setValue("application/json", forHTTPHeaderField: "Content-Type")
    }
    
    mutating func setHeaders(from headers: [String: String]) {
          for (key, value) in headers {
              self.setValue(value, forHTTPHeaderField: key)
          }
      }
}
