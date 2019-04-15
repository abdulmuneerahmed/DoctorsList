//
//  Enum.swift
//  Think360
//
//  Created by admin on 14/04/19.
//  Copyright © 2019 AcknoTech. All rights reserved.
//

import Foundation

enum UrlValues:String {
    case Key = "Authorization"
    case Value = "bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJqdGkiOiI3YTU2ZmQ3MS00ZTBlLTQ1ODYtOTk2MC01ZGM1NWVjNDhjODAiLCJzdWIiOiJjaGFuZHJhLnRoaW5rMzYwQGdtYWlsLmNvbSIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL25hbWUiOiJjaGFuZHJhLnRoaW5rMzYwQGdtYWlsLmNvbSIsInVzZXJpZCI6ImNoYW5kcmEudGhpbmszNjBAZ21haWwuY29tIiwicGdpZCI6IjEiLCJleHAiOjE1NzE4MjcwNzgsImlzcyI6Imh0dHBzOi8vcWEyLnRlbGVkZW50aXguY29tIiwiYXVkIjoiaHR0cHM6Ly9xYTIudGVsZWRlbnRpeC5jb20ifQ.aFb5NAuN-tCPa8uhXmjjw5oYn8cZQ0ptIzppnsHlqac"
    
    func getValue()->String{
        return self.rawValue
    }
}
