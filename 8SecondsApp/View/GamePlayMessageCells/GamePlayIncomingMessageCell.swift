//
//  GamePlayIncomingMessageCell.swift
//  8SecondsApp
//
//  Created by Ataberk Canıtez on 22.03.2020.
//  Copyright © 2020 Ataberk Canıtez. All rights reserved.
//

import UIKit

class GamePlayIncomingMessageCell: UICollectionViewCell{
    
    let messageLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.layer.cornerRadius = 15
        label.layer.borderColor = UIColor.black.cgColor
        label.layer.borderWidth = 2
        label.text = "***"
        label.textAlignment = .center
        
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setupViews(){
        setupLabel()
    }
    
    private func setupLabel(){
        addSubview(messageLabel)
        NSLayoutConstraint.activate([
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            messageLabel.topAnchor.constraint(equalTo: topAnchor),
            messageLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            messageLabel.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
}
