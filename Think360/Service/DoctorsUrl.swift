//
//  DoctorsApi.swift
//  Think360
//
//  Created by admin on 14/04/19.
//  Copyright © 2019 AcknoTech. All rights reserved.
//

import Foundation

class DoctorsUrl{
    
    static let service = DoctorsUrl()
    
    
    private init(){}
    
    func generateApiRequest(pageNumber page:Int)->URLRequest?{
        let header = UrlValues.Key.getValue()
        let value = UrlValues.Value.getValue()
        let numPages = 5
        let details = true
        let urlString = "https://qa2.teledentix.com/api/networks/connections?itemPerPage=\(numPages)&currentPageNum=\(page)&needDetails=\(details)"
        
        guard let url = URL(string: urlString) else { return nil}
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue(value, forHTTPHeaderField: header)
        return request
    }
}
