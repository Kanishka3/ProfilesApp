//
//  CellType.swift
//  ProfilesApp
//
//  Created by Kanishka Chaudhry on 08/11/24.
//

import Foundation

enum CellType {
    case titleSubtitle(title: String, subtitle: String, cta: String)
    case image(profile: Profile)
    case gridImage(profile: InviteProfile, canSeeProfile: Bool)
}
