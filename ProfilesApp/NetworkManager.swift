//
//  NetworkManager.swift
//  ProfilesApp
//
//  Created by Kanishka Chaudhry on 06/11/24.
//

import Foundation

class NetworkManager {
    
    enum MethodType: String {
        case get = "GET"
        case post = "POST"
    }
    
    func fetchApi(url: String,
                  params: [String: String] = [:],
                  headers: [String: String] = [:],
                  body: [String: String] = [:],
                  methodType: MethodType = .post,
                  completion: @escaping (Bool, [String: Any]?) -> Void) {
        
        guard var urlComponents = URLComponents(string: url) else {
            completion(false, nil)
            return
        }
        
        urlComponents.queryItems = params.map { URLQueryItem(name: $0.key, value: $0.value) }
        
        guard let finalURL = urlComponents.url else {
            completion(false, nil)
            return
        }
        
        var request = URLRequest(url: finalURL)
        request.httpMethod = methodType.rawValue
        request.setJSONBody(from: body)
        request.setHeaders(from: headers)

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                completion(false, nil)
                return
            }
            if let httpResponse = response as? HTTPURLResponse, let data, httpResponse.statusCode == 200 {
                let dict = try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
                completion(true, dict)
            } else {
                completion(false, nil)
            }
        }.resume()
    }
    
    func fetchApi(url: String,
                  token: String,
                  completion: @escaping (NotesResponse?) -> Void) {
        
        guard let url = URL(string: url) else {
            completion(nil)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = MethodType.get.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(token, forHTTPHeaderField: "Authorization")
        request.setValue("", forHTTPHeaderField: "If-None-Match") 
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                completion(nil)
                return
            }
            if let httpResponse = response as? HTTPURLResponse, let data, httpResponse.statusCode == 200 {
                let response = try? JSONDecoder().decode(NotesResponse.self, from: data)
                completion(response)
            } else {
                completion(nil)
            }
        }.resume()
    }
}

