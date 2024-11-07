//
//  ImageList.swift
//  ProfilesApp
//
//  Created by Kanishka Chaudhry on 07/11/24.
//

import UIKit

class ProfileCollectionViewCell: UICollectionViewCell {

    private let profileImageView = UIImageView()
    private let titleStackView = UIStackView()
    private let titleLabel1 = UILabel()
    private let titleLabel2 = UILabel()
    private let blurView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return blurEffectView
    }()

    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        createViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Create Views
    private func createViews() {
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.clipsToBounds = true
        profileImageView.layer.cornerRadius = 16
        contentView.addSubview(profileImageView)

        titleStackView.translatesAutoresizingMaskIntoConstraints = false
        titleStackView.axis = .vertical
        titleStackView.spacing = 4
        titleStackView.alignment = .fill
        profileImageView.addSubview(blurView)
        profileImageView.addSubview(titleStackView)

        titleLabel1.font = UIFont.boldSystemFont(ofSize: 22)
        titleStackView.addArrangedSubview(titleLabel1)

        titleLabel2.font = UIFont.systemFont(ofSize: 14)
        titleLabel2.textColor = .gray
        titleStackView.addArrangedSubview(titleLabel2)

        profileImageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        profileImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        profileImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        let width = frame.width - 24
        profileImageView.widthAnchor.constraint(equalToConstant: width).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: width).isActive = true
        
        
        blurView.leadingAnchor.constraint(equalTo: profileImageView.leadingAnchor).isActive = true
        blurView.trailingAnchor.constraint(equalTo: profileImageView.trailingAnchor).isActive = true
        blurView.topAnchor.constraint(equalTo: profileImageView.topAnchor).isActive = true
        blurView.bottomAnchor.constraint(equalTo: profileImageView.bottomAnchor).isActive = true
        blurView.isHidden = true
        
        titleStackView.leadingAnchor.constraint(equalTo: profileImageView.leadingAnchor, constant: 16).isActive = true
        titleStackView.trailingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: -16).isActive = true
        titleStackView.bottomAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: -8).isActive = true
        titleLabel1.textColor = .white
        titleLabel2.textColor = .white
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel2.isHidden = true
        blurView.isHidden = true
    }

    func setData(profile: Profile) {
        if let photoUrlString = profile.photos?.first?.photo, let url = URL(string: photoUrlString) {
            profileImageView.loadImage(from: url)
        }
        if let firstName = profile.generalInformation?.firstName,
           let age = profile.generalInformation?.age {
            titleLabel1.text = "\(firstName), \(age)"
        }
        titleLabel2.text = GlobalConstants.profileSubtitle
        titleLabel2.isHidden = false
        blurView.isHidden = true
    }
    
    func setData(profile: InviteProfile, canSeeProfile: Bool) {
        if let photoUrlString = profile.avatar, let url = URL(string: photoUrlString) {
            profileImageView.loadImage(from: url)
        }
        if let firstName = profile.firstName {
            titleLabel1.text = "\(firstName)"
        }
        titleLabel2.isHidden = true 
        blurView.isHidden = canSeeProfile
    }
}
