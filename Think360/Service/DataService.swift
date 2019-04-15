//
//  DataService.swift
//  Think360
//
//  Created by admin on 14/04/19.
//  Copyright © 2019 AcknoTech. All rights reserved.
//

import Foundation

class DataService{
    static let service = DataService()
    
    private init(){}
    
    var doctorsData:[CellData] = []
    
    var totalCount:TotalCount?
    
    func getDoctorsDetails()->[CellData]{
        return doctorsData
    }
    
    func returnTotalCount()->TotalCount?{
        return totalCount
    }
    
}
