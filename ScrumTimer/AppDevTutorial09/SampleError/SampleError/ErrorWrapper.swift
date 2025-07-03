//
//  SampleError.swift
//  SampleError
//
//  Created by sakiyamaK on 2025/05/23.
//

import Foundation

struct ErrorWrapper: Identifiable {
    var id: UUID = UUID()
    var error: Error
}

struct SampleError: Error {
    var message: String
}

struct SampleError2: Error {
    var errorNo: Int
}
