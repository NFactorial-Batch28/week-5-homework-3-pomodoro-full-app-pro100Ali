//
//  Tome.swift
//  PomodoraUIKit
//
//  Created by Али  on 06.05.2023.
//

import Foundation

class Time {
    var minutes: Int
    var seconds: Int
    var type: Task
    init(minutes: Int, seconds: Int, type: Task) {
        self.minutes = minutes
        self.seconds = seconds
        self.type = type
    }
}


enum Task {
    case focusTime
    case breakTime
}
