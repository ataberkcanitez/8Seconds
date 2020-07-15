//
//  GameRoom.swift
//  8SecondsApp
//
//  Created by Ataberk Canıtez on 11.07.2020.
//  Copyright © 2020 Ataberk Canıtez. All rights reserved.
//

import Foundation

class GameRoom{
    var admin: String
    var player: String
    var roomId: String
    var status: String
    var round: Int
    
    var firstQuestion: String
    var firstAnswer: String
    
    var secondQuestion:String
    var secondAnswer: String
    
    var thirdQuestion: String
    var thirdAnswer: String
    
    var fourthQuestion:String
    var fourthAnswer: String
    
    var fiftQhuestion: String
    var fifthAnswer: String
    
    var adminAnswer: String
    var playerAnswer: String
    
    init(admin: String, player: String, roomId: String, status: String, round: Int, firstQuestion: String, secondQuestion: String, thirdQuestion: String, fourthQuestion: String, fiftQuestion: String, firstAnswer: String, secondAnswer:String, thirdAnswer: String, fourthAnswer: String, fifthAnswer: String, adminAnswer:String, playerAnswer: String) {
        self.admin = admin
        self.player = player
        self.roomId = roomId
        self.status = status
        self.round = round
        
        self.firstQuestion = firstQuestion
        self.firstAnswer = firstQuestion
        
        self.secondQuestion = secondQuestion
        self.secondAnswer = secondAnswer
        
        self.thirdQuestion = thirdQuestion
        self.thirdAnswer = thirdAnswer
        
        self.fourthQuestion = fourthQuestion
        self.fourthAnswer = fourthAnswer
        
        self.fiftQhuestion = fiftQuestion
        self.fifthAnswer = fifthAnswer
        
        self.adminAnswer = adminAnswer
        self.playerAnswer = playerAnswer
        
        
        
        
    }
    
    
}
