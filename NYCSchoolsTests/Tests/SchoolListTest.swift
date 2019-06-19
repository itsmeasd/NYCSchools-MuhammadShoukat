//
//  SchoolListTest.swift
//  NYCSchools-MuhammadShoukat
//
//  Created by Asad Ali on 6/16/19.
//  Copyright © 2019 Muhammad Shoukat. All rights reserved.
//

import XCTest
@testable import NYCSchools

class SchoolListTest: XCTestCase {
    let emtySchoolServiceMock = SchoolServiceMock(schools: [])
    let oneSchoolServiceMock = SchoolServiceMock(schools: [School(dbn: "123456", school_name: "Test School", website: "www")])
    
    func testShouldSetSchools() {
        //given
        let schoolListViewMock = SchoolListViewMock()
        let schoolListPresenterUnderTest = SchoolListPresenter(schoolService: oneSchoolServiceMock)
        schoolListPresenterUnderTest.attachView(view: schoolListViewMock)
        
        //when
        schoolListPresenterUnderTest.getSchools()
        
        //verify
        XCTAssertTrue(schoolListViewMock.setSchoolsCalled)
    }
    
    func testShouldSetEmptyIfNoSchoolsAvailable() {
        //given
        let schoolListViewMock = SchoolListViewMock()
        let schoolListPresenterUnderTest = SchoolListPresenter(schoolService: emtySchoolServiceMock)
        schoolListPresenterUnderTest.attachView(view: schoolListViewMock)
        
        //when
        schoolListPresenterUnderTest.getSchools()
        
        //verify
        XCTAssertTrue(schoolListViewMock.setEmptyCalled)
    }
    
}
