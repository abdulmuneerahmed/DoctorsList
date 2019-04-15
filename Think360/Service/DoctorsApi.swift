//
//  DoctorsApi.swift
//  Think360
//
//  Created by admin on 14/04/19.
//  Copyright © 2019 AcknoTech. All rights reserved.
//

import Foundation

class DoctorsApi{
    static let service = DoctorsApi()
    
    private let doctorsCellData = DataService.service
    
    private init(){}
    
    func retriveJsonData(UrlRequest request:URLRequest, completionHandler: @escaping (_ status:Bool)->()){
        URLSession.shared.dataTask(with: request) {[weak self] (data, response, error) in
            
            guard let self = self else{return}
            
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,(200...299).contains(httpResponse.statusCode)else{
                print(response.debugDescription)
                return
            }
            
            guard let responseData = data else{return}
            
            do{
                let decoder = JSONDecoder()
                
                let doctorsData = try decoder.decode(DoctorsData.self, from: responseData)
                //print(doctorsData)
                
                if doctorsData.success{
                    for details in doctorsData.data.connections{
                        if let detail = details.inviteeProvider {
                            self.decodeData(data: detail)
                        }else{
                            guard let detail = details.inviterProvider else{return}
                            self.decodeData(data: detail)
                        }
                    }
                    self.doctorsCellData.totalCount = TotalCount(totalCount: doctorsData.data.totalCount)
                }
                completionHandler(true)
            }catch let errore as NSError{
                print(errore.userInfo)
                completionHandler(false)
            }
            
            }.resume()
    }
    
    private func decodeData(data doctorsData:Details){
        var detailsData:[String] = []
        var licentureData:[String] = []
        var officeName = ""
        var city = ""
        var stateCode = ""
        var zip = ""
        var photoId = ""
        if !doctorsData.degrees.isEmpty{
            for detail in doctorsData.degrees{
                detailsData.append(detail.qualification)
            }
        }
        let fullname = doctorsData.fullName
        
        if !doctorsData.licensure.isEmpty{
            for licensure in doctorsData.licensure{
                licentureData.append(licensure.specializations)
            }
        }
        
        if !doctorsData.offices.isEmpty{
             officeName = doctorsData.offices[0].name
             city = doctorsData.offices[0].city
             stateCode = doctorsData.offices[0].stateCode
             zip = doctorsData.offices[0].zip
        }
        
        if let photo = doctorsData.photoId{
             photoId = photo
        }
        
        
        doctorsCellData.doctorsData.append(CellData(photo: photoId, fullname: fullname, degree: detailsData, specialization: licentureData, officeName: officeName, city: city, stateCode: stateCode, zip: zip))
    }
}
