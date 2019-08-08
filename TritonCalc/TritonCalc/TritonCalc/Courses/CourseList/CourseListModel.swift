//
//  CourseListModel.swift
//  TritonCalc
//
//  Created by Josh Hollandsworth on 8/3/19.
//  Copyright © 2019 Joshholl. All rights reserved.
//

import Foundation
import UIKit
import CoreData

final class CourseListModel {
    private var courseList: CourseList
    private var persistence: TritonCalcPersistence
    
    private weak var delegate: ModelRefreshDelegate?
    
    var count: Int {
        get{
            return courseList.count }
    }
    let rowHeight: Double = 64.0
    
    init(persistence: TritonCalcPersistence, delegate: ModelRefreshDelegate) {
        self.delegate = delegate
        self.persistence = persistence
        self.courseList = []
    }
    
    func getCourses() {
        self.courseList = persistence.coureses
        self.delegate?.refresh()
    }
}

extension CourseListModel {
    func course(at index: Int) -> Course? {
        return courseList.element(at: index)
    }
    
    func deleteCourse(at index: Int) {
        guard let course = courseList.element(at: index) else {
            return
        }
        
        if(course.isSubstitue == true) {
            let gpa = self.persistence.currentGpa
            let newHours = gpa.hours + course.creditHours
            let newPoints = gpa.pointsEarned + (course.previousGrade?.rawValue.pointValue ?? 0)
            
            self.persistence.save(gpa: GradePointAverage(hours: newHours, pointsEarned: newPoints))
        }
        self.persistence.delete(course: course)
        getCourses()
    }
}
