//
//  SchoolListViewController.swift
//  NYCSchools-MuhammadShoukat
//
//  Created by Asad Ali on 6/16/19.
//  Copyright © 2019 Muhammad Shoukat. All rights reserved.
//

import UIKit

class SchoolListViewController: UIViewController {
    
    @IBOutlet weak var emptyView: UIView?
    @IBOutlet weak var tableView: UITableView?
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView?
    
    private let schoolListPresenter = SchoolListPresenter(schoolService: SchoolServiceAPI())
    private var schoolsToDisplay = [SchoolViewData]()
    private var loadingCells = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.emptyView?.isHidden = true
        self.tableView?.isHidden = true
        tableView?.dataSource = self
        tableView?.prefetchDataSource = self
        tableView?.tableFooterView = UIView()
        
        schoolListPresenter.attachView(view: self)
        schoolListPresenter.getSchools(limit: loadingCells, offset: schoolsToDisplay.count + 1)
    }
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let schoolDetailVC = segue.destination as? SchoolDetailViewController{
            if let indexPath = self.tableView?.indexPathsForSelectedRows?.first{
                schoolDetailVC.schoolToDisplay = self.schoolsToDisplay[indexPath.row]
            }
        }
    }
    
    func isLoadingCell(for indexPath: IndexPath) -> Bool {
        return indexPath.row >= schoolsToDisplay.count
    }
    
    func visibleIndexPathsToReload(intersecting indexPaths: [IndexPath]) -> [IndexPath] {
        let indexPathsForVisibleRows = tableView!.indexPathsForVisibleRows ?? []
        let indexPathsIntersection = Set(indexPathsForVisibleRows).intersection(indexPaths)
        return Array(indexPathsIntersection)
    }
    
}

extension SchoolListViewController: UITableViewDataSource{
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.schoolsToDisplay.count + loadingCells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(isLoadingCell(for: indexPath)){
            let cell = tableView.dequeueReusableCell(withIdentifier: "LoadingCell", for: indexPath)
            if let activityIndicatorView = cell.viewWithTag(1) as? UIActivityIndicatorView{
                activityIndicatorView.startAnimating()
            }
            
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "SchoolCell", for: indexPath)
            let schoolViewData = schoolsToDisplay[indexPath.row]
            cell.textLabel?.text = schoolViewData.name
            cell.detailTextLabel?.text = schoolViewData.website
            return cell
        }
    }
}

extension SchoolListViewController: UITableViewDataSourcePrefetching{
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(where: isLoadingCell) {
            schoolListPresenter.getSchools(limit: loadingCells, offset: schoolsToDisplay.count + 1)
        }
    }
}

extension SchoolListViewController: SchoolListView {
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
    
    func setSchools(schools: [SchoolViewData], error: Error?) {
        DispatchQueue.main.async{
            if let error = error {
                self.showAlert(massage: error.localizedDescription, errTitle: "Error")
                self.loadingCells = 0
            } else if(schools.count == 0){
                self.loadingCells = 0
            }
            self.schoolsToDisplay += schools
            self.emptyView?.isHidden = true
            self.tableView?.isHidden = false
            self.tableView?.reloadData()
        }
    }
    
    func setEmpty() {
        DispatchQueue.main.async{
            self.tableView?.isHidden = true
            self.emptyView?.isHidden = false
        }
    }
    
}
