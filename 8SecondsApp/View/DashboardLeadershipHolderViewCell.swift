//
//  DashboardLeadershipHolderViewCell.swift
//  8SecondsApp
//
//  Created by Ataberk Canıtez on 21.03.2020.
//  Copyright © 2020 Ataberk Canıtez. All rights reserved.
//

import UIKit

class DashboardLeadershipHolderViewCell: UICollectionViewCell {
    
    var users = [User](){
        didSet{
            leadershipCollectionView.reloadData()
        }
    }
    
    let leadershipCellIdentifier: String = "leadershipCellIdentifier"
    
    let leadershipCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .clear
        
        
        return cv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setupViews(){
        setupCollectionView()
    }
    
    
    private func setupCollectionView(){
        addSubview(leadershipCollectionView)
        leadershipCollectionView.fillSuperview()
        leadershipCollectionView.delegate = self
        leadershipCollectionView.dataSource = self
        
        leadershipCollectionView.register(LeadershipCollectionViewCell.self, forCellWithReuseIdentifier: leadershipCellIdentifier)
    }
    
}



extension DashboardLeadershipHolderViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return users.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let leadershipCell = collectionView.dequeueReusableCell(withReuseIdentifier: leadershipCellIdentifier, for: indexPath) as! LeadershipCollectionViewCell
        let index = indexPath.item
        leadershipCell.rankingLabel.text = "\(index + 1)"
        
        let user = users[indexPath.item]
        leadershipCell.user = user
        
        return leadershipCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: frame.width, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    
    
    
    
}
