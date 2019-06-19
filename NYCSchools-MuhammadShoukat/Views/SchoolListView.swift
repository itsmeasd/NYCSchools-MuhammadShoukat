//
//  SchoolListView.swift
//  NYCSchools-MuhammadShoukat
//
//  Created by Asad Ali on 6/16/19.
//  Copyright © 2019 Muhammad Shoukat. All rights reserved.
//

import Foundation

protocol SchoolView: AnyObject{
    func startLoading()
    func finishLoading()
    func setEmpty()
}

protocol SchoolListView: SchoolView{
    func setSchools(schools: [SchoolViewData], error: Error?)
}

protocol SchoolDetailView: SchoolView{
    func setSchoolDetail(schoolStats: SchoolStatViewData?, error: Error? )
}
