//
//  Mood.swift
//  Moodoo
//
//  Created by Michael Moscoso on 5/1/18.
//  Copyright © 2018 Natascha Brauchle. All rights reserved.
//

import Foundation

class UserMood {
    
    var angry:String
    var happy:String
    var excited:String
    var sad:String
    var sleep:String
    var reasons:String
    var date:String
    var user:AppUser?
    
    init(angry:String, happy:String, excited:String, sad:String, sleep:String, reasons:String, date:String, user:AppUser) {
        self.angry = angry
        self.happy = happy
        self.excited = excited
        self.sad = sad
        self.sleep = sleep
        self.reasons = reasons
        self.date = date
        self.user = user
    }
    
}
