//
//  LoginModel.swift
//  ChargerApp
//
//  Created by Aki Wang on 2020/10/13.
//

import Foundation

struct LoginModel : Codable {
    
    let data : Data?
    let result : Bool?
    
    enum CodingKeys: String, CodingKey {
        case data
        case result = "result"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(Data.self, forKey: .data)
        result = try values.decodeIfPresent(Bool.self, forKey: .result)
    }
    
    struct Data : Codable {
        
        let apiToken : String?
        let userId : Int?
        
        enum CodingKeys: String, CodingKey {
            case apiToken = "api_token"
            case userId = "user_id"
        }
        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            apiToken = try values.decodeIfPresent(String.self, forKey: .apiToken)
            userId = try values.decodeIfPresent(Int.self, forKey: .userId)
        }
    }
}
