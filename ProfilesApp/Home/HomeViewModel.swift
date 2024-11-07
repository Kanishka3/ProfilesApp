//
//  HomeViewModel.swift
//  ProfilesApp
//
//  Created by Kanishka Chaudhry on 07/11/24.
//

import Foundation

class HomeViewModel {
    private let networkManager = NetworkManager()
    private var token: String
    public private(set) var dataSource = [[CellType]]() // sections

    init(token: String) {
        self.token = token
    }
    
    func fetchApi(completion: @escaping ((NotesResponse) -> Void)) {
        networkManager.fetchApi(url: GlobalConstants.baseUrl + GlobalConstants.profileEndPoint,
                                token: token) { [weak self] response in
            guard let self else { return }
            
            var section1 = [CellType]()
            response?.invites?.profiles?.forEach({
                section1.append(.image(profile: $0))
            })
            section1.append(.titleSubtitle(title: GlobalConstants.interestedTitle,
                                           subtitle: GlobalConstants.interestedSubtitle,
                                           cta: GlobalConstants.interestedButtonCTA))
            dataSource.append(section1)
            
            var section2 = [CellType]()
            
            response?.likes?.profiles?.forEach({
                section2.append(.gridImage(profile: $0,
                                           canSeeProfile: response?.likes?.canSeeProfile ?? false))
            })
            dataSource.append(section2)
            if let response {
                completion(response)
            }
        }
    }
}
