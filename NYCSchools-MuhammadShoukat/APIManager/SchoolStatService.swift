//
//  SchoolStatService.swift
//  NYCSchools-MuhammadShoukat
//
//  Created by Asad Ali on 6/16/19.
//  Copyright © 2019 Muhammad Shoukat. All rights reserved.
//

import Foundation
class SchoolStatService {
    
    func getSchoolStatData(dbn: String, callBack:@escaping (SchoolStat?, Error?) -> Void){
        
        //Implementing URLSession
        let urlString = K.Server.URL + "734v-jeq5.json"
        let urlComponents = NSURLComponents(string: urlString)
        urlComponents?.queryItems = [URLQueryItem(name: "$$app_token", value: K.Server.appToken),
                                     URLQueryItem(name: "dbn", value: dbn)
        ]
        
        guard let url = urlComponents?.url else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                callBack(nil, error)
            }
            guard let data = data else {
                callBack(nil,error)
                return
            }
            
            guard let schools = try? JSONDecoder().decode([SchoolStat].self, from: data) else{
                callBack(nil,error)
                return
            }
            
            callBack(schools.first,error)
            
            }.resume()
    }
}

