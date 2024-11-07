//
//  HomeViewController.swift
//  ProfilesApp
//
//  Created by Kanishka Chaudhry on 07/11/24.
//

import UIKit



class HomeViewController: UIViewController,
                          UICollectionViewDataSource,
                          UICollectionViewDelegateFlowLayout {
    
    private var viewModel: HomeViewModel
    
    private var collectionView: UICollectionView?
    
    init(token: String) {
        self.viewModel = HomeViewModel(token: token)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCV()
        createViews()
        
        viewModel.fetchApi { [weak self] _ in
            DispatchQueue.main.async {
                self?.collectionView?.collectionViewLayout.invalidateLayout()
                self?.collectionView?.reloadData()
            }
        }
    }
    
    private func createViews() {
        guard let collectionView else { return }
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView.showsVerticalScrollIndicator = false
    }
    
    private func setupCV() {
        
        let layout = setCompositionalLayout()
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = GlobalConstants.interitemSpacing
        layout.configuration = config
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        guard let collectionView else { return }
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(TitleSubtitleCell.self, forCellWithReuseIdentifier: TitleSubtitleCell.self.description())
        collectionView.register(ProfileCollectionViewCell.self, forCellWithReuseIdentifier: ProfileCollectionViewCell.self.description())

    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        viewModel.dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.dataSource[section].count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellType = viewModel.dataSource[indexPath.section][indexPath.row]
        switch cellType {
        case .titleSubtitle(title: let title, subtitle: let subt, cta: let cta):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleSubtitleCell.self.description(),
                                                                for: indexPath) as? TitleSubtitleCell else {
                return collectionView.blankCell(forIndexPath: indexPath)
            }
            cell.configure(title: title, subtitle: subt, buttonTitle: cta)
            return cell
        case .image(profile: let data):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileCollectionViewCell.self.description(),
                                                                for: indexPath) as? ProfileCollectionViewCell else {
                return collectionView.blankCell(forIndexPath: indexPath)
            }
            cell.setData(profile: data)
            return cell
        case .gridImage(profile: let inviteProfile, canSeeProfile: let canSeeProfile):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileCollectionViewCell.self.description(),
                                                                for: indexPath) as? ProfileCollectionViewCell else {
                return collectionView.blankCell(forIndexPath: indexPath)
            }
            cell.setData(profile: inviteProfile, canSeeProfile: canSeeProfile)
            return cell
        }
    }
}


extension HomeViewController {
    private func setCompositionalLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { [weak self] index, _ in
            guard let self,
                  let cellType = viewModel.dataSource[safe: index] else { return NSCollectionLayoutSection.default }
            
            if case .gridImage(profile: _) = cellType.first {
                
                let item = NSCollectionLayoutItem(
                    layoutSize: .init(
                        widthDimension: .fractionalWidth(1/2),
                        heightDimension: .fractionalWidth(1/2)
                    )
                )
                
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalWidth(1)
                )
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item, item])
                return NSCollectionLayoutSection(group: group)
            }
            return NSCollectionLayoutSection.default
        }
    }
    
}
