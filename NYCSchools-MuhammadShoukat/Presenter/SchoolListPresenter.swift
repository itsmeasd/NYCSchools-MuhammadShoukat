//
//  SchoolListPresenter.swift
//  NYCSchools-MuhammadShoukat
//
//  Created by Asad Ali on 6/16/19.
//  Copyright © 2019 Muhammad Shoukat. All rights reserved.
//

import Foundation

class SchoolListPresenter {
    private let schoolService: SchoolService
    weak private var view : SchoolListView?
    var isFetchInProgress = false
    
    init(schoolService: SchoolService){
        self.schoolService = schoolService
    }
    
    func attachView(view: SchoolListView){
        self.view = view
    }
    
    func detachView() {
        view = nil
    }
    
    func getSchools(limit: Int = 10, offset: Int = 1){
        
        guard !isFetchInProgress else {
            return
        }
        
        if(offset == 1){
            self.view?.startLoading()
        }
        
        isFetchInProgress = true
        
        self.schoolService.getSchools(limit: limit, offset: offset) { (schools , error) in
            self.isFetchInProgress = false
            
            if(offset == 1){
                self.view?.finishLoading()
                if(schools.count == 0){
                    self.view?.setEmpty()
                }
            }
            
            let mappedSchools = schools.map({
                return SchoolViewData(dbn: $0.dbn, name: $0.school_name, website: $0.website)
            })
            
            self.view?.setSchools(schools: mappedSchools, error: error)
        }
    }
}
