//
//  HomeModel.swift
//  ProfilesApp
//
//  Created by Kanishka Chaudhry on 07/11/24.
//

import Foundation


typealias Profile = NotesResponse.Invites.Profiles
typealias InviteProfile = NotesResponse.Likes.Profiles

struct NotesResponse: Codable {
    let invites: Invites?
    let likes: Likes?
    
    struct Invites: Codable {
        let profiles: [Profiles]?
        
        struct Profiles: Codable {
            let photos: [Photos]?
            let generalInformation: GeneralInformation?
            
            struct Photos: Codable {
                let photo: String?
                let selected: Bool?
                let status: String?
            }
            
            struct GeneralInformation: Codable {
                let firstName: String?
                let age: Int?
                
                enum CodingKeys: String, CodingKey {
                    case firstName = "first_name"
                    case age
                }
            }
            
            enum CodingKeys: String, CodingKey {
                case photos
                case generalInformation = "general_information"
            }
        }
        
        enum CodingKeys: String, CodingKey {
            case profiles
        }
    }
    
    struct Likes: Codable {
        let canSeeProfile: Bool?
        let profiles: [Profiles]?
        
        struct Profiles: Codable {
            let firstName: String?
            let avatar: String?
            
            enum CodingKeys: String, CodingKey {
                case firstName = "first_name"
                case avatar
            }
        }
        
        enum CodingKeys: String, CodingKey {
            case profiles
            case canSeeProfile = "can_see_profile"
        }
    }
}
