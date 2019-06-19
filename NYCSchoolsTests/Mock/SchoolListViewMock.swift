//
//  SchoolListViewMock.swift
//  NYCSchools-MuhammadShoukat
//
//  Created by Asad Ali on 6/16/19.
//  Copyright © 2019 Muhammad Shoukat. All rights reserved.
//

@testable import NYCSchools

class SchoolListViewMock: SchoolListView {
    
    var setSchoolsCalled = false
    var setLoadingCalled = false
    var setFinishCalled = false
    var setEmptyCalled = false
    
    func setSchools(schools: [SchoolViewData], error: Error?) {
        setSchoolsCalled = true
    }
    
    func startLoading() {
        setLoadingCalled = true
    }
    
    func finishLoading() {
        setFinishCalled = true
    }
    
    func setEmpty() {
        setEmptyCalled = true
    }
}

