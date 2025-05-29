//
//  Int+.swift
//  AppDevTutorial09
//
//  Created by sakiyamaK on 2025/04/13.
//


extension Int {
    var doubleValue: Double {
        get {
            Double(self)
        }
        set {
            self = Int(newValue)
        }
    }
}
