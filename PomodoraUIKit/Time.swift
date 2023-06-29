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
    init(minutes: Int, seconds: Int) {
        self.minutes = minutes
        self.seconds = seconds
    }
}


enum Task: String {
    case focusTime = "Focus time"
    case breakTime = "Break Time"
}
