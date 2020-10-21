//
//  ApiService.swift
//  ChargerApp
//
//  Created by Aki Wang on 2020/10/13.
//

import Foundation

import Foundation
import Alamofire

struct ApiService{
    static var defApiAddress = "traq.smtcub.com"
    static var baseURL: String {
        get{
            return UserDefaultsManager.getInstance().getApiAddress()
        }
    }
    
    /** sample 同步 */
    static func Sample(email: String, password: String) -> ApiResponse<LoginModel>{
        let url = "\(baseURL)auth/login"//URL
        let headers = [
            "Authorization": "Bearer \(UserDefaultsManager.getInstance().getApiToken())",
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        let parameters = [
            "email" : "\(email)",
            "password" : "\(password)"
        ]
        let result: ApiResponse<LoginModel> = ApiTool.execute(url: url, method: .post, parameters: parameters , headers: headers)
        return result
    }
    
    /** sample 異步 */
    static func Sample(email: String, password: String, callBack: @escaping  (ApiResponse<LoginModel>) -> Void){
        let url = "\(baseURL)auth/login"//URL
        let headers = [
            "Authorization": "Bearer \(UserDefaultsManager.getInstance().getApiToken())",
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        let parameters = [
            "email" : "\(email)",
            "password" : "\(password)"
        ]
        //異步
        ApiTool.request(url: url, method: .post, parameters: parameters , headers: headers, callBack: callBack)
    }
    
    /** 登入 */
    static func login(account: String, password: String) -> ApiResponse<LoginModel>{
        let url = "\(baseURL)auth/login"
        let headers = [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
        var parameters = [String:Any]()
        parameters["device_token"] = UserDefaultsManager.getInstance().getDeviceToken()
        parameters["account"] = account
        parameters["password"] = password
        parameters["system"] = "ios"
        let result: ApiResponse<LoginModel> = ApiTool.execute(url: url, method: .post, parameters: parameters , headers: headers)
        return result
    }
    
    /** 台北市 youbike  **/
    static func getTapieiYouBikeStation() -> ApiResponse<TapipeiYouBikeStationModel>{
        let url = "https://tcgbusfs.blob.core.windows.net/blobyoubike/YouBikeTP.json"
        let headers = [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
        let result: ApiResponse<TapipeiYouBikeStationModel> = ApiTool.execute(url: url, method: .get, headers: headers)
        return result
    }
    
    
}
