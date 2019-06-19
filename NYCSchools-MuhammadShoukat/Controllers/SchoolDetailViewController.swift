//
//  SchoolDetailViewController.swift
//  NYCSchools-MuhammadShoukat
//
//  Created by Asad Ali on 6/16/19.
//  Copyright © 2019 Muhammad Shoukat. All rights reserved.
//

import UIKit

class SchoolDetailViewController: UIViewController {
    
    @IBOutlet weak var lblSchoolDetail: UITextView!
    @IBOutlet weak var emptyView: UIView?
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView?
    
    private let schoolDetailPresenter = SchoolDetailPresenter(schoolStatService: SchoolStatService())
    var schoolToDisplay: SchoolViewData!
    private var schoolStatToDisplay: SchoolStatViewData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.emptyView?.isHidden = true
        schoolDetailPresenter.attachView(view: self)
        schoolDetailPresenter.getSchoolStat(dbn: schoolToDisplay.dbn)
    }
}

extension SchoolDetailViewController: SchoolDetailView{
    func startLoading() {
        DispatchQueue.main.async{
            self.activityIndicator?.startAnimating()
        }
    }
    
    func finishLoading() {
        DispatchQueue.main.async{
            self.activityIndicator?.stopAnimating()
        }
    }
    
    func setSchoolDetail(schoolStats: SchoolStatViewData?, error: Error?) {
        DispatchQueue.main.async{
            self.schoolStatToDisplay = schoolStats
            ///Controller extenston
            if let error = error {
                self.showAlert(massage: error.localizedDescription, errTitle: "Error")
            }
            else {
                self.displayStats()
            }
        }
    }
    
    func setEmpty() {
        DispatchQueue.main.async{
            self.emptyView?.isHidden = false
            self.lblSchoolDetail.isHidden = true
        }
    }
    
    func displayStats() {
        guard let schoolStatViewData = self.schoolStatToDisplay else {
            self.emptyView?.isHidden = false
            return
        }
        self.lblSchoolDetail.text = "School Name: " + schoolStatViewData.schoolName
            + "\nTotal Test: " + schoolStatViewData.totalTests
            + "\nMath Average Score:" + schoolStatViewData.mathAvgData
            + "\nCritical Reading Average Score:" + schoolStatViewData.criticalReadingAvgData
            + "\nWriting Average Score:" + schoolStatViewData.writingAvgData

    }
    
}




