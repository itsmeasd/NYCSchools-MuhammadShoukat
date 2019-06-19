//
//  SchoolDetailPresenter.swift
//  NYCSchools-MuhammadShoukat
//
//  Created by Asad Ali on 6/16/19.
//  Copyright © 2019 Muhammad Shoukat. All rights reserved.
//

import Foundation

class SchoolDetailPresenter {
    private let schoolStatService: SchoolStatService
    weak private var view : SchoolDetailView?
    
    init(schoolStatService: SchoolStatService){
        self.schoolStatService = schoolStatService
    }
    
    func attachView(view: SchoolDetailView){
        self.view = view
    }
    
    func detachView() {
        view = nil
    }
    
    func getSchoolStat(dbn: String){
        self.view?.startLoading()
        self.schoolStatService.getSchoolStatData(dbn: dbn, callBack: { (schoolStats, error) in
            self.view?.finishLoading()
            guard let schoolStats = schoolStats else {
                self.view?.setEmpty()
                self.view?.setSchoolDetail(schoolStats: nil, error : error)
                return
            }
            let schoolStateData = SchoolStatViewData(totalTests: schoolStats.num_of_sat_test_takers, criticalReadingAvgData: schoolStats.sat_critical_reading_avg_score ,mathAvgData: schoolStats.sat_math_avg_score, writingAvgData: schoolStats.sat_writing_avg_score, schoolName: schoolStats.school_name)
            
            
            self.view?.setSchoolDetail(schoolStats: schoolStateData, error : error)
        })
    }
}
