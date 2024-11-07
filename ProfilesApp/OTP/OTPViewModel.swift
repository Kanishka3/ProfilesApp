//
//  OTPViewModel.swift
//  ProfilesApp
//
//  Created by Kanishka Chaudhry on 07/11/24.
//

import Foundation

class OTPViewModel {
    
    let networkManager = NetworkManager()
    
    func fetchApi(for phoneNumber: String, otp: String, completion: @escaping ((String?, Bool) -> Void)) {
        networkManager.fetchApi(url: GlobalConstants.baseUrl + GlobalConstants.otpEndpoint,
                                body: ["number": phoneNumber, "otp": otp]) { isSuccess, response in
            completion(response?["token"] as? String, isSuccess)
        }
    }
}
