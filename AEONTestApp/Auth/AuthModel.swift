//
//  AuthModel.swift
//  AEONTestApp
//
//  Created by Nikita Makarov on 02.07.2021.
//

import Foundation

// MARK: - GetToken
struct GetToken: Decodable {
    let success: String
    let response: Responses?
    let error: Error?
}

// MARK: - Response
struct Responses: Codable {
    let token: String
}
// MARK: - Errors
struct Error: Decodable {
    let code: Int
    let errorMes: String
    
    
    enum CodingKeys: String, CodingKey {
        case code = "error_code"
        case errorMes = "error_msg"
    }
}




