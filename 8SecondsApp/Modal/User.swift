//
//  User.swift
//  8SecondsApp
//
//  Created by Ataberk Canıtez on 11.07.2020.
//  Copyright © 2020 Ataberk Canıtez. All rights reserved.
//

import Foundation


class User{
    var uid: String
    var fullName: String
    var city: String
    var sex: String
    var birthday: String
    var email: String
    
    var profilePhoto: String?
    var totalPoint: Int?
    
    
    
    init(uid: String,fullname: String, city:String, sex: String, birthday: String, email:String, profilePhoto: String?, totalPoint: Int?) {
        self.uid = uid
        self.fullName = fullname
        self.city = city
        self.sex = sex
        self.birthday = birthday
        self.email = email
        self.profilePhoto = profilePhoto
        self.totalPoint = totalPoint
    }
}

class UserToRegister{
    var fullName: String
    var city: String
    var sex: String
    var birthday: String
    var email: String
    var password: String
    
    init(fullname: String, city:String, sex: String, birthday: String, email:String, password: String) {
        self.fullName = fullname
        self.city = city
        self.sex = sex
        self.birthday = birthday
        self.email = email
        self.password = password
    }
}

