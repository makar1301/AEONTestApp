//
//  PaymentsModel.swift
//  AEONTestApp
//
//  Created by Nikita Makarov on 02.07.2021.
//





import Alamofire

// MARK: - Welcome
struct Payments: Codable {
    let success: String
    let response: [Response]
}

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseResponse { response in
//     if let response = response.result.value {
//       ...
//     }
//   }

// MARK: - Response
struct Response: Codable {
    let desc: String
    let amount: Amount
    let currency: String?
    let created: Date
}

enum Amount: Codable {
    case integer(Int)
    case double(Double)
    case string(String)


    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }

        throw DecodingError.typeMismatch(Amount.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Amount"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .double(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)

        }
    }
}






 
