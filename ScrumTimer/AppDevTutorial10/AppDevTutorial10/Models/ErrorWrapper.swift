//
//  ErrorWrapper.swift
//  AppDevTutorial10
//
//  Created by sakiyamaK on 2025/04/13.
//

import Foundation

struct ErrorWrapper: Identifiable {
    let id: UUID = UUID()
    let error: Error
    let guidance: String
}
