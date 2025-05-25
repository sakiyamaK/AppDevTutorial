//
//  ErrorWrapper.swift
//  SampleError
//
//  Created by sakiyamaK on 2025/05/23.
//

import Foundation

struct SampleError: Error, Identifiable {
    let id: UUID = UUID()
    var message: String
}
