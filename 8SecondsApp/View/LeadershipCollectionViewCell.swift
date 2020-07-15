//
//  LeadershipCollectionViewCell.swift
//  8SecondsApp
//
//  Created by Ataberk Canıtez on 21.03.2020.
//  Copyright © 2020 Ataberk Canıtez. All rights reserved.
//

import UIKit

class LeadershipCollectionViewCell: UICollectionViewCell {
    
    var user: User?{
        didSet{
            setProfilePhoto()
            setName()
            setPoint()
        }
    }
    
    private func setProfilePhoto(){
        if let user = user{
            if let profilePhotoUrl = user.profilePhoto{
                profilePhotoView.loadImageUsingUrlString(urlString: profilePhotoUrl)
            }else{
                profilePhotoView.image = #imageLiteral(resourceName: "launchLogo")
            }
        }
    }
    
    private func setName(){
        if let user = user{
            nameLabel.text = user.fullName
        }
    }
    private func setPoint(){
        if let user = user{
            if let point = user.totalPoint{
                totalWinsLabel.text = String(point)
            }else{
                totalWinsLabel.text = "0"
            }
        }
    }
    
    let rankingLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
        
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        
        return label
    }()
    
    let profilePhotoView: RemoteImages = {
        let iv = RemoteImages(frame: .zero)
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.layer.cornerRadius = 17 // Anlık boyut 40, 3 de alttan ve 3 üstten padding var
        iv.layer.borderColor = UIColor.black.cgColor
        iv.layer.borderWidth = 1
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFit
        
        return iv
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.text = "Ataberk Canıtez"
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        
        return label
    }()
    
    let totalWinsTitleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.text = "Puan:"
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        
        return label
    }()
    
    let totalWinsLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = #colorLiteral(red: 0.9332545996, green: 0.9333854914, blue: 0.9332134128, alpha: 1)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    private func setupViews(){
        setupBorders()
        setupRankingLabel()
        setupProfilePhoto()
        setupNameLabel()
        setupTotalWins()
        setupTotalWinsTitle()
    }
    private func setupBorders(){
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.cgColor
    }
    
    private func setupRankingLabel(){
        addSubview(rankingLabel)
        NSLayoutConstraint.activate([
            rankingLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            rankingLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15)
        ])
    }
    private func setupProfilePhoto(){
        addSubview(profilePhotoView)
        NSLayoutConstraint.activate([
            profilePhotoView.leadingAnchor.constraint(equalTo: rankingLabel.trailingAnchor, constant: 15),
            profilePhotoView.topAnchor.constraint(equalTo: topAnchor, constant: 3),
            profilePhotoView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -3),
            profilePhotoView.widthAnchor.constraint(equalTo: profilePhotoView.heightAnchor)
        ])
    }
    private func setupNameLabel(){
        addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: profilePhotoView.trailingAnchor, constant: 5)
        ])
    }
    private func setupTotalWins(){
        addSubview(totalWinsLabel)
        NSLayoutConstraint.activate([
            totalWinsLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            totalWinsLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    private func setupTotalWinsTitle(){
        addSubview(totalWinsTitleLabel)
        NSLayoutConstraint.activate([
            totalWinsTitleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            totalWinsTitleLabel.trailingAnchor.constraint(equalTo: totalWinsLabel.leadingAnchor, constant: -15)
        ])
    }
    
    
    
}
