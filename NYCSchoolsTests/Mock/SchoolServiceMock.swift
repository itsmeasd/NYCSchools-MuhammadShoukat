//
//  SchoolServiceMock.swift
//  NYCSchools-MuhammadShoukat
//
//  Created by Asad Ali on 6/16/19.
//  Copyright © 2019 Muhammad Shoukat. All rights reserved.
//

@testable import NYCSchools

class SchoolServiceMock: SchoolService{
    let schools: [School]
    
    init(schools: [School]) {
        self.schools = schools
    }
    
    func getSchools(limit: Int, offset: Int, callBack: @escaping ([School], Error?) -> Void) {
        callBack(schools, nil)
    }
}
