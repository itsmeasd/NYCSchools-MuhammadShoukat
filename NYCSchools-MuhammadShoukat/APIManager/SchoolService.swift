//
//  SchoolService.swift
//  NYCSchools-MuhammadShoukat
//
//  Created by Asad Ali on 6/16/19.
//  Copyright © 2019 Muhammad Shoukat. All rights reserved.
//

import Foundation

protocol SchoolService {
    func getSchools(limit: Int, offset: Int, callBack:@escaping ([School], Error?) -> Void)
}

class SchoolServiceAPI: SchoolService {
    
    func getSchools(limit: Int, offset: Int, callBack:@escaping ([School], Error?) -> Void){
        
        //Implementing URLSession
        let urlString = K.Server.URL + "97mf-9njv.json"
        let urlComponents = NSURLComponents(string: urlString)
        urlComponents?.queryItems = [URLQueryItem(name: "$$app_token", value: K.Server.appToken),
                                     URLQueryItem(name: "$limit", value: "\(limit)"),
                                     URLQueryItem(name: "$offset", value: "\(offset)"),
                                     URLQueryItem(name: "$select", value: "dbn,school_name,website")
        ]
        
        guard let url = urlComponents?.url else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                callBack([], error)
            }
            guard let data = data else {
                callBack([],error)
                return
            }
            
            guard let schools = try? JSONDecoder().decode([School].self, from: data) else{
                callBack([],error)
                return
            }
            
            callBack(schools,error)
            
            }.resume()
    }
}
