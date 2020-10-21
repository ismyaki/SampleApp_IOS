//
//  UserDefaultsManager.swift
//  SmatQDemo
//
//  Created by Aki Wang on 2019/4/2.
//  Copyright © 2019 smartq. All rights reserved.
//

import Foundation

class UserDefaultsManager: NSObject{
    private static let recordInstance = UserDefaultsManager()
    static private var instance : UserDefaultsManager { return recordInstance }
    @objc static func getInstance() -> UserDefaultsManager { return instance }
    
    //MARK: Init with dependency
    private override init() {
        //Use the default container for production environment
    }
    
    
    let ud = UserDefaults.standard
    
    //Proj Setting
    /** lang 語系*/
    let KEY_LANG = "lang"
    let KEY_API_ADDRESS = "KEY_API_ADDRESS"
    let KEY_DEVICE_TOKEN = "KEY_DEVICE_TOKEN"
    let KEY_IS_LOGIN = "KEY_IS_LOGIN"
    let KEY_USER_ID = "KEY_USER_ID"
    let KEY_API_TOKEN = "KEY_API_TOKEN"
    
    func setLang(lang: String){
        ud.set(lang, forKey: KEY_LANG)
    }
    
    func getLang() -> String{
        return ud.value(forKey: KEY_LANG) as? String ?? ""
    }
    
    func setApiAddress(address: String){
        ud.set(address, forKey: KEY_API_ADDRESS)
    }
    
    func getApiAddress() -> String{
        let address = ud.value(forKey: KEY_API_ADDRESS) as? String
        if address != nil && address != "" {
            return address ?? ApiService.defApiAddress
        }
        return ApiService.defApiAddress
    }
    
    func setDeviceToken(apiToken: String){
        ud.set(apiToken, forKey: KEY_DEVICE_TOKEN)
    }
    
    func getDeviceToken() -> String{
        return ud.value(forKey: KEY_DEVICE_TOKEN) as? String ?? ""
    }
    
    func setLogin(isLogin: Bool){
        ud.set(isLogin, forKey: KEY_IS_LOGIN)
    }
    
    func isLogin() -> Bool {
        return ud.value(forKey: KEY_IS_LOGIN) as? Bool ?? false
    }
    
    func setUserId(userId: Int){
        ud.set(userId, forKey: KEY_USER_ID)
    }
    
    func getUserId() -> Int{
        return ud.value(forKey: KEY_USER_ID) as? Int ?? 0
    }
    
    func setApiToken(apiToken: String){
        ud.set(apiToken, forKey: KEY_API_TOKEN)
    }
    
    func getApiToken() -> String{
        return ud.value(forKey: KEY_API_TOKEN) as? String ?? ""
    }
    
}
