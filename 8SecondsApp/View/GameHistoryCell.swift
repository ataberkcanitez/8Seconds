//
//  GameHistoryCell.swift
//  8SecondsApp
//
//  Created by Ataberk Canıtez on 22.03.2020.
//  Copyright © 2020 Ataberk Canıtez. All rights reserved.
//

import UIKit


class GameHistoryCell: UICollectionViewCell {
    
    let myProfilePhotoView: UIImageView = {
        let iv = UIImageView(frame: .zero)
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = UIImage(named: "dogus")
        iv.layer.cornerRadius = 17 // Anlık boyut 40, 3 de alttan ve 3 üstten padding var
        iv.layer.borderColor = UIColor.black.cgColor
        iv.layer.borderWidth = 1
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFit
        
        return iv
    }()
    let vsLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "vs"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        
        return label
    }()
    let opponentPhotoView: UIImageView = {
        let iv = UIImageView(frame: .zero)
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = UIImage(named: "dogus")
        iv.layer.cornerRadius = 17 // Anlık boyut 40, 2 de alttan ve üstten padding var
        iv.layer.borderColor = UIColor.black.cgColor
        iv.layer.borderWidth = 1
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFit
        
        return iv
    }()
    let gameScoreLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "3 - 2"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        
        return label
    }()
    let resultLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "KAZANDIN"
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0, green: 0.6063765883, blue: 0, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        
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
        setupMyProfilePhoto()
        setupVersusLabel()
        setupOpponentPhoto()
        setupGameScoreLabel()
        setupResultLabel()
    }
    private func setupBorders(){
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.cgColor
    }
    
    private func setupMyProfilePhoto(){
        addSubview(myProfilePhotoView)
        NSLayoutConstraint.activate([
            myProfilePhotoView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            myProfilePhotoView.topAnchor.constraint(equalTo: topAnchor, constant: 3),
            myProfilePhotoView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -3),
            myProfilePhotoView.widthAnchor.constraint(equalTo: myProfilePhotoView.heightAnchor)
        ])
    }
    private func setupVersusLabel(){
        addSubview(vsLabel)
        NSLayoutConstraint.activate([
            vsLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            vsLabel.leadingAnchor.constraint(equalTo: myProfilePhotoView.trailingAnchor, constant: 15)
        ])
    }
    private func setupOpponentPhoto(){
        addSubview(opponentPhotoView)
        NSLayoutConstraint.activate([
            opponentPhotoView.leadingAnchor.constraint(equalTo: vsLabel.trailingAnchor, constant: 15),
            opponentPhotoView.topAnchor.constraint(equalTo: topAnchor, constant: 3),
            opponentPhotoView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -3),
            opponentPhotoView.widthAnchor.constraint(equalTo: opponentPhotoView.heightAnchor)
        ])
    }
    private func setupGameScoreLabel(){
        addSubview(gameScoreLabel)
        NSLayoutConstraint.activate([
            gameScoreLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            gameScoreLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    private func setupResultLabel(){
        addSubview(resultLabel)
        NSLayoutConstraint.activate([
            resultLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            resultLabel.leadingAnchor.constraint(equalTo: gameScoreLabel.trailingAnchor),
            resultLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
}
