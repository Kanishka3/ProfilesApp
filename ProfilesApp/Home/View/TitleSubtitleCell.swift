//
//  TitleSubtitleCell.swift
//  ProfilesApp
//
//  Created by Kanishka Chaudhry on 07/11/24.
//

import UIKit

class TitleSubtitleCell: UICollectionViewCell {
    
    // MARK: - UI Components
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let actionButton = UIButton(type: .system)
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4
        return stackView
    }()
    
    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(subtitleLabel)
        
        contentView.addSubview(actionButton)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12).isActive = true
        stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        
        actionButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12).isActive = true
        actionButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        actionButton.leadingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: 22).isActive = true
        
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        subtitleLabel.font = UIFont.systemFont(ofSize: 16)
        subtitleLabel.textColor = .gray
        
        actionButton.setStandardStyle()
        [titleLabel, subtitleLabel].forEach {
            $0.numberOfLines = 0
            $0.setContentCompressionResistancePriority(UILayoutPriority.defaultHigh, for: .vertical)
        }
    }
    
    // MARK: - Configure Cell
    func configure(title: String, subtitle: String, buttonTitle: String) {
        titleLabel.text = title
        subtitleLabel.text = subtitle
        actionButton.setTitle(buttonTitle, for: .normal)
    }
}
