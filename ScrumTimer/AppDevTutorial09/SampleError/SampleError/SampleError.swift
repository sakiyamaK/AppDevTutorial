//
//  SampleError.swift
//  SampleError
//
//  Created by sakiyamaK on 2025/05/23.
//

import Foundation

struct Japanese: Identifiable {
    var id: String { name }
    var name: String
}

struct SampleError: Error, Identifiable {
    var id: UUID = UUID()
    var message: String
}

struct SampleError2: Error, Identifiable {
    var id: UUID = UUID()
    var errorNo: Int
}
