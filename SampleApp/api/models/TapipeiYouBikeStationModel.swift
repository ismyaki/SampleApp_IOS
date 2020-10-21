//
//  GetGoogleModel.swift
//  ChargerApp
//
//  Created by 蔡彥佑 on 2020/10/16.
//

import Foundation

struct TapipeiYouBikeStationModel : Codable {
    
    let retVal : [String: RetVal]?
    var retCode : Int?
    
    enum CodingKeys: String, CodingKey {
        case retVal = "retVal"
        case retCode = "retCode"

    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        retVal = try values.decodeIfPresent([String: RetVal].self, forKey: .retVal)
        retCode = try values.decodeIfPresent(Int.self, forKey: .retCode)
    }
    
    /**
     * sno(站點代號)、sna(中文場站名稱)、tot(場站總停車格)、
     * sbi(可借車位數)、sarea(中文場站區域)、mday(資料更新時間)、
     * lat(緯度)、lng(經度)、ar(中文地址)、
     * sareaen(英文場站區域)、snaen(英文場站名稱)、aren(英文地址)、
     * bemp(可還空位數)、act(場站是否暫停營運)
     * */
    struct RetVal: Codable  {
        let sno : String?
        let sna : String?
        let tot : String?
        let sbi : String?
        let sarea : String?
        let mday : String?
        let lat : String?
        let lng : String?
        let ar : String?
        let sareaen : String?
        let snaen : String?
        let aren : String?
        let bemp : String?
        let act : String?
        
        enum CodingKeys: String, CodingKey {
            case sno = "sno"
            case sna = "sna"
            case tot = "tot"
            case sbi = "sbi"
            case sarea = "sarea"
            case mday = "mday"
            case lat = "lat"
            case lng = "lng"
            case ar = "ar"
            case sareaen = "sareaen"
            case snaen = "snaen"
            case aren = "aren"
            case bemp = "bemp"
            case act = "act"
        }
        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            sno = try values.decodeIfPresent(String.self, forKey: .sno)
            sna = try values.decodeIfPresent(String.self, forKey: .sna)
            tot = try values.decodeIfPresent(String.self, forKey: .tot)
            sbi = try values.decodeIfPresent(String.self, forKey: .sbi)
            sarea = try values.decodeIfPresent(String.self, forKey: .sarea)
            mday = try values.decodeIfPresent(String.self, forKey: .mday)
            lat = try values.decodeIfPresent(String.self, forKey: .lat)
            lng = try values.decodeIfPresent(String.self, forKey: .lng)
            ar  = try values.decodeIfPresent(String.self, forKey: .ar )
            sareaen = try values.decodeIfPresent(String.self, forKey: .sareaen)
            snaen = try values.decodeIfPresent(String.self, forKey: .snaen)
            aren = try values.decodeIfPresent(String.self, forKey: .aren)
            bemp = try values.decodeIfPresent(String.self, forKey: .bemp)
            act = try values.decodeIfPresent(String.self, forKey: .act)
        }
    }
}
