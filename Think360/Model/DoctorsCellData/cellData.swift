//
//  cellData.swift
//  Think360
//
//  Created by admin on 14/04/19.
//  Copyright © 2019 AcknoTech. All rights reserved.
//

import Foundation

struct CellData{
    let photo:String
    let fullname:String
    let degree:[String]
    let specialization:[String]
    let officeName:String
    let city:String
    let stateCode:String
    let zip:String
    init(photo:String,fullname:String,degree:[String],specialization:[String],officeName:String,city:String,stateCode:String,zip:String) {
        self.photo = photo
        self.fullname = fullname
        self.degree = degree
        self.specialization = specialization
        self.officeName = officeName
        self.city = city
        self.stateCode = stateCode
        self.zip = zip
    }
}

struct TotalCount{
    let totalCount:Int
    init(totalCount:Int) {
        self.totalCount = totalCount
    }
}
