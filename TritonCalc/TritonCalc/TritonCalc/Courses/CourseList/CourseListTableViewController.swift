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
    private var model: CourseListCollectionModel!
    
    



}

extension CourseListTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model.listAt(index: section)?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let course = model.listAt(index: indexPath.section)!.courseAt(index: indexPath.row)!

        
        
        
        
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CourseCell", for: indexPath) as! CourseListTableViewCell
        cell.forCourse(course)
        return cell
    }
}
