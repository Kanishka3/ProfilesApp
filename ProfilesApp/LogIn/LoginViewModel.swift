//
//  LoginViewModel.swift
//  ProfilesApp
//
//  Created by Kanishka Chaudhry on 06/11/24.
//

import Foundation

class LoginViewModel {
    
    let networkManager = NetworkManager()
    
    func login(for number: String, completion: @escaping ((Bool)->Void)) {
        networkManager.fetchApi(url: GlobalConstants.baseUrl + GlobalConstants.loginEndpoint,
                                body: ["number": number]) { isSucces, response in
            if let success = response?["status"] as? Bool, success == true {
                completion(true)
            } else {
                completion(false)
            }
        }
    }
}
