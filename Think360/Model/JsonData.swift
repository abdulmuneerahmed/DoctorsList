//
//  JsonData.swift
//  Think360
//  Created by admin on 14/04/19.
//  Copyright © 2019 AcknoTech. All rights reserved.
//

import Foundation

struct DoctorsData:Codable {
    let data:DataDoc
    let success:Bool
    let total_count:Int
}

struct DataDoc:Codable {
    let connections:[Connection]
    let totalCount:Int
}

struct Connection:Codable {
    let inviteeProvider:Details?
    let inviterProvider:Details?
}

struct Details:Codable {
    let degrees:[Degrees]
    let fullName:String
    let licensure:[Licensure]
    let offices:[Offices]
    let photoId:String?
}

struct Degrees:Codable{
    let qualification:String
}

struct Licensure:Codable {
    let specializations:String
}

struct Offices:Codable {
    let name:String
    let city:String
    let stateCode:String
    let zip:String
}
