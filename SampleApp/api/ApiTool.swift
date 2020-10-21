//
//  ApiTooil.swift
//  SmatCubeProtoType
//
//  Created by Aki Wang on 2019/5/10.
//  Copyright © 2019 smartq. All rights reserved.
//

import Foundation
import Alamofire
import UIKit

extension Encodable {
    func toJsonData() -> Data? {
        return try? JSONEncoder().encode(self)
    }
    
    func toJsonString() -> String {
        do {
            let jsonEncoder = JSONEncoder()
            let jsonData = try jsonEncoder.encode(self)
            return String(data: jsonData, encoding: .utf8) ?? "{}"
        } catch {
            
        }
        return "{}"
    }
}

extension Dictionary {
    func toJsonData() -> Data? {
        return try? JSONSerialization.data(withJSONObject: self, options: [])
    }
    
    func toJsonString() -> String {
        if let josnData = try? JSONSerialization.data(withJSONObject: self, options: []) {
            return String(data: josnData, encoding: .utf8) ?? "{}"
        }
        return "{}"
    }
}

extension String {
    func toCodable<T : Codable>() -> T?{
        guard let jsonData = self.data(using: .utf8) else { return nil }
        let decoder = JSONDecoder()
        return try? decoder.decode(T.self, from: jsonData)
    }
    
    func toJsonData() -> Data? {
        return try? JSONSerialization.data(withJSONObject: self, options: [])
    }
    
    func toDictionary() -> [String: Any]? {
        if let data = self.data(using: .utf8) {
            return try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        }
        return nil
    }
}

class ApiError {
    var statusCode = 0
    var errorString: String
    var errorJson: [String: Any]
    
    init(statusCode: Int, errorJson: [String: Any], errorString: String) {
        self.statusCode = statusCode
        self.errorJson = errorJson
        self.errorString = errorString
    }
}

class ApiResponse<T> {
    var statusCode = 0
    var isSuccess: Bool = false
//    {
//        get{
//            if statusCode == 200{
//                return true
//            } else {
//                return false
//            }
//        }
//    }
    
    var response: DataResponse<Any>
    var data: T?
    var error: ApiError?
    var errorString: String?
    var errorJson:[String: Any]?
    
    init(response:DataResponse<Any>){
        self.response = response
    }
}

struct ApiTool{
    private static let TAG = "ApiTool"
    
    static func upload<T : Codable>(url: String, imageKeyName:String, path: String, method: HTTPMethod = .get, headers: HTTPHeaders? = nil) -> ApiResponse<T>{
        log(TAG, "upload url \(url)")
        log(TAG, "upload headers \(String(describing: headers))")
        log(TAG, "upload method \(method)")
        let semaphone = DispatchSemaphore(value: 0)
        var result :ApiResponse<T>? = nil
        let image = UIImage(contentsOfFile: path)
        let data = image?.jpegData(compressionQuality: 0.5)
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                if data != nil {
                    multipartFormData.append(data!, withName: imageKeyName,fileName: "file.jpg", mimeType: "image/jpg")
                }
            },
            to: url, method: .post, headers: headers) { (uploadResult) in
                switch uploadResult {
                case .success(let upload, _, _):
                    upload.uploadProgress(closure: { (progress) in
                        log(TAG, "upload Progress: \(progress.fractionCompleted)")
                    })
                    upload.responseJSON { response in
                        log(TAG, "upload statusCode \(response.response?.statusCode ?? 0)")
                        result = ApiResponse<T>(response: response)
                        result?.isSuccess = response.result.isSuccess
                        result?.statusCode = response.response?.statusCode ?? 0
                        if response.result.isSuccess {
                            let decoder = JSONDecoder()
                            if let data = response.data, let model = try? decoder.decode(T.self, from: data) {
                                result?.data = model
                            } else {
                                //                        print("Error...")
                            }
                        }else{
                            if let data = response.data {
                                result?.errorString = data2String(data: data)
                                result?.errorJson = data2Json(data: data)
                                if result?.errorJson != nil {
                                    result?.error = ApiError(statusCode: result?.statusCode ?? 0, errorJson: result?.errorJson ?? [:], errorString: result?.errorString ?? "")
                                }
                            }
                        }
                        semaphone.signal()
                    }
                case .failure(let encodingError):
                    print(encodingError)
                }
            }
        _ = semaphone.wait(timeout: .distantFuture)
        return result!
    }
    
    static func execute<T : Codable>(url: String, method: HTTPMethod = .get, parameters: Parameters? = nil, headers: HTTPHeaders? = nil) -> ApiResponse<T>{
        log(TAG, "execute url \(url)")
        log(TAG, "execute headers \(String(describing: headers))")
        log(TAG, "execute parameters \(String(describing: parameters))")
        log(TAG, "execute method \(method)")
        let startTime = Date()
        log(TAG, "execute start time \(startTime.toString("yyyy-MM-dd HH:mm:ss:SSS"))")
        let semaphone = DispatchSemaphore(value: 0)
        var result :ApiResponse<T>? = nil
        Alamofire.request(url, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .validate()
            .validate(statusCode: 200..<300)
            .responseJSON{(response) in
                log(TAG, "execute statusCode \(response.response?.statusCode ?? 0)")
                result = ApiResponse<T>(response: response)
                result?.isSuccess = response.result.isSuccess
                result?.statusCode = response.response?.statusCode ?? 0
                if response.result.isSuccess {
                    let decoder = JSONDecoder()
                    if let data = response.data, let model = try? decoder.decode(T.self, from: data) {
                        result?.data = model
                    } else {
//                        print("Error...")
                    }
                }else{
                    if let data = response.data {
                        result?.errorString = data2String(data: data)
                        result?.errorJson = data2Json(data: data)
                        if result?.errorJson != nil {
                            result?.error = ApiError(statusCode: result?.statusCode ?? 0, errorJson: result?.errorJson ?? [:], errorString: result?.errorString ?? "")
                        }
                    }
                }
                semaphone.signal()
            }
        _ = semaphone.wait(timeout: .distantFuture)
        let stopTime = Date()
        log(TAG, "execute stop time \(stopTime.toString("yyyy-MM-dd HH:mm:ss:SSS"))")
        log(TAG, "execute run time \(Int((stopTime.timeIntervalSince1970 * 1000) - (startTime.timeIntervalSince1970 * 1000)))ms")
        return result!
    }
    
    static func executeData(url: String, method: HTTPMethod = .get, parameters: Parameters? = nil, headers: HTTPHeaders? = nil) -> DataResponse<Any>{
        log(TAG, "executeData url \(url)")
        log(TAG, "executeData headers \(String(describing: headers))")
        log(TAG, "executeData parameters \(String(describing: parameters))")
        log(TAG, "executeData method \(method)")
        let semaphone = DispatchSemaphore(value: 0)
        var result :DataResponse<Any>? = nil
        Alamofire.request(url, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .validate()
            .validate(statusCode: 200..<300)
            .responseJSON{(response) in
                log(TAG, "executeData statusCode \(response.response?.statusCode ?? 0)")
                result = response
                semaphone.signal()
        }
        _ = semaphone.wait(timeout: .distantFuture)
        return result!
    }
    
    static func request<T : Codable>(url: String, method: HTTPMethod = .get, parameters: Parameters? = nil, headers: HTTPHeaders? = nil, callBack: @escaping  (ApiResponse<T>) -> Void){
        log(TAG, "response url \(url)")
        log(TAG, "response headers \(String(describing: headers))")
        log(TAG, "response parameters \(String(describing: parameters))")
        log(TAG, "response method \(method)")
        Alamofire.request(url, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .validate()
            .validate(statusCode: 200..<300)
            .responseJSON{(response) in
                log(TAG, "request statusCode \(response.response?.statusCode ?? 0)")
                let result = ApiResponse<T>(response: response)
                result.isSuccess = response.result.isSuccess
                result.statusCode = response.response?.statusCode ?? 0
                if response.result.isSuccess {
                    let decoder = JSONDecoder()
                    if let data = response.data, let model = try? decoder.decode(T.self, from: data) {
                        result.data = model
                    } else {
                        print("Error...")
                    }
                }else{
                    if let data = response.data {
                        result.errorString = data2String(data: data)
                        result.errorJson = data2Json(data: data)
                    }
                }
                callBack(result)
            }
    }
    
    static func requestData(url: String, method: HTTPMethod = .get, parameters: Parameters? = nil, headers: HTTPHeaders? = nil, callBack: @escaping  (DataResponse<Any>) -> Void){
        log(TAG, "responseData url \(url)")
        log(TAG, "responseData headers \(String(describing: headers))")
        log(TAG, "responseData parameters \(String(describing: parameters))")
        log(TAG, "responseData method \(method)")
        Alamofire.request(url, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .validate()
            .validate(statusCode: 200..<300)
            .responseJSON{(response) in
                log(TAG, "requestData statusCode \(response.response?.statusCode ?? 0)")
                callBack(response)
            }
    }
    
    static func data2Json(data: Data) -> [String: Any]?{
        var json:[String: Any]? = nil
        json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        return json
    }
    
    static func data2String(data: Data) -> String?{
        return String(data: data, encoding: .utf8)
    }
    
    static func string2Data(str: String) -> Data?{
        return str.data(using: .utf8)
    }
    
    static func string2Json(str: String) -> [String: Any]?{
        if let data = string2Data(str: str) {
            return data2Json(data: data)
        }
        return nil
    }
    
    static func json2Data(json: [String: Any]) -> Data?{
        return try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
    }
    
    static func json2String(json: [String: Any]) -> String?{
        if let data = json2Data(json: json) {
            return data2String(data: data)
        }
        return nil
    }
}
