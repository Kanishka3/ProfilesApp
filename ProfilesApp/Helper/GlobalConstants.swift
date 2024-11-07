//
//  GlobalConstants.swift
//  ProfilesApp
//
//  Created by Kanishka Chaudhry on 06/11/24.
//

import UIKit

enum GlobalConstants {
    static let loginSubtitle = "Get OTP"
    static let loginTitle = "Enter Your Phone Number"
    static let buttonCta = "Continue"
    static let otpTitle = "Enter The OTP"
    
    static let interestedTitle = "Interested In You"
    static let interestedSubtitle = "Premium members can view all likes at once"
    static let interestedButtonCTA = "Upgrade"
    
    static let profileSubtitle = "Tap to review 50+ notes"
    
    
    static let phoneWidth = UIScreen.main.bounds.width
    static let phoneHeight = UIScreen.main.bounds.height
    
    static let interitemSpacing = CGFloat(12)
    
    static let sidePadding = CGFloat(16)
    
    
    static let loginEndpoint = "/users/phone_number_login"
    static let baseUrl = "https://app.aisle.co/V1"
    static let otpEndpoint = "/users/verify_otp"
    static let profileEndPoint = "/users/test_profile_list"
    
    static let loginFailed = "Invalid Login"
    static let otpFailed = "OTP Failed"
}

