//
//  AppUser.swift
//  Moodoo
//
//  Created by Michael Moscoso on 3/28/18.
//  Copyright © 2018 Group6. All rights reserved.
//

import Foundation

class AppUser {
    
    var username:String
    var password:String
    var email:String
    var moodCount:Int
    
    init(username:String, password:String, email:String, moodCount:Int) {
        self.username = username
        self.password = password
        self.email = email
        self.moodCount = moodCount
    }
    
}
