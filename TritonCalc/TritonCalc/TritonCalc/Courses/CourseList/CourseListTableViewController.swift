//
//  CourseListTableViewController.swift
//  TritonCalc
//
//  Created by Josh Hollandsworth on 8/3/19.
//  Copyright © 2019 Joshholl. All rights reserved.
//

import Foundation
import UIKit

final class CourseListTableViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    private var model: CourseListModel!
}


extension CourseListTableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        model = CourseListModel(persistence: TritonCalcPersistence(), delegate: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.isHidden = true
        activityIndicator.startAnimating()
        model.getCourses()
    }
}

extension CourseListTableViewController: ModelRefreshDelegate{
    func refresh() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
            self?.tableView.isHidden = false
            self?.activityIndicator.stopAnimating()
        }
    }
}
extension CourseListTableViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let upsertController = segue.destination as? CourseUpsertViewController {
            let course = sender as? Course
            
            let courseModel = CourseUpsertModel(course: course, persistence: TritonCalcPersistence() , delegate: self)
            upsertController.for(model: courseModel)
        }
    }
    
    func deleteCourse(at index: Int) {
        tableView.isHidden = true
        activityIndicator.startAnimating()
    
        self.model.deleteCourse(at: index)
    }
}


extension CourseListTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CourseCell", for: indexPath) as! CourseListTableViewCell
        let course = model.course(at: indexPath.row)!
        cell.forCourse(course)
        return cell
    }
    
}

extension CourseListTableViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(model.rowHeight)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! CourseListTableViewCell
        
        performSegue(withIdentifier: "showUpsert", sender: cell.course)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            let cell = tableView.cellForRow(at: indexPath) as! CourseListTableViewCell

            let alertController = UIAlertController(title: "Delete Course \(cell.course.name)?", message: "Confirm", preferredStyle: .alert)
            alertController.addAction( UIAlertAction(title: "Yes", style: .default, handler:
                { (_) in self.deleteCourse(at: indexPath.row)
                    
                   }))
            alertController.addAction( UIAlertAction(title: "Cancel", style: .cancel ))
            self.present(alertController, animated: true)
        default:
            break
        }
    }
}

