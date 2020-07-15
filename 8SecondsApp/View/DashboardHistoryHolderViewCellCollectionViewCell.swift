//
//  DashboardHistoryHolderViewCellCollectionViewCell.swift
//  8SecondsApp
//
//  Created by Ataberk Canıtez on 21.03.2020.
//  Copyright © 2020 Ataberk Canıtez. All rights reserved.
//

import UIKit

class DashboardHistoryHolderViewCellCollectionViewCell: UICollectionViewCell {
    
    let gameHistoryCellIdentifier: String = "gameHistoryCellIdentifier"
    
    let gameHistoryCollectionView: UICollectionView = {
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
        addSubview(gameHistoryCollectionView)
        gameHistoryCollectionView.fillSuperview()
        gameHistoryCollectionView.delegate = self
        gameHistoryCollectionView.dataSource = self
        
        gameHistoryCollectionView.register(GameHistoryCell.self, forCellWithReuseIdentifier: gameHistoryCellIdentifier)
    }
}


extension DashboardHistoryHolderViewCellCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let gameHistoryCell = collectionView.dequeueReusableCell(withReuseIdentifier: gameHistoryCellIdentifier, for: indexPath) as! GameHistoryCell
        
        return gameHistoryCell
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
