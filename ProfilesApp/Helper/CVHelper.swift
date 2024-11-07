//
//  CVHelper.swift
//  ProfilesApp
//
//  Created by Kanishka Chaudhry on 08/11/24.
//

import UIKit


final class FallbackBlankCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "FallbackBlankCollectionViewCell"
}

extension UICollectionView {
    func blankCell(forIndexPath: IndexPath) -> UICollectionViewCell {
        register(
            FallbackBlankCollectionViewCell.self,
            forCellWithReuseIdentifier: FallbackBlankCollectionViewCell.reuseIdentifier
        )
        return dequeueReusableCell(
            withReuseIdentifier: FallbackBlankCollectionViewCell.reuseIdentifier,
            for: forIndexPath
        )
    }
}

extension NSCollectionLayoutSection {
    static var `default`: NSCollectionLayoutSection {
        
        let item = NSCollectionLayoutItem(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1),
                heightDimension: .estimated(100)
            )
        )
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(100)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
}



