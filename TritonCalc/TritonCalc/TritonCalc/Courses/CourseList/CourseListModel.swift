//
//  CourseListModel.swift
//  TritonCalc
//
//  Created by Josh Hollandsworth on 8/3/19.
//  Copyright © 2019 Joshholl. All rights reserved.
//

import Foundation
import UIKit


typealias CourseList = [Course]

extension CourseList {
    var totalHours: Int {
        return self.reduce(0, { sum, next in sum + next.creditHours })
    }
    
    var gpa: GradePointAverage {
        get {
        let applicableCourses = self.filter{$0.grade != nil}
        
        return GradePointAverage(hours: applicableCourses.reduce(0, {sum, next in sum + next.creditHours}),
                                 pointsEarned: applicableCourses.reduce(0, {sum, next in sum + next.points}))
        }
    }
}

protocol CourseListModelDelegate {
    func dataRefreshed()
}


final class CourseListModel {
    private let persistence: GpaPersistable
    private var courseList: CourseList
    private var delegate: CourseListModelDelegate
    
    
    var count: Int { return courseList.count }
    let rowHeight: Double = 64.0
    
    init(delegate: CourseListModelDelegate) {
        self.delegate = delegate
        self.persistence = ApplicationSession.sharedInstance.persistence
        self.courseList = persistence.courseProjections
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

        persistence.remove(course: course)
        courseList = persistence.courseProjections
        delegate.dataRefreshed()
    }
}


extension CourseListModel: CourseUpsertModelDelegate {
    func save(course: Course) {
        courseList.append(course)
        persistence.save(course: course)
        delegate.dataRefreshed()
    }
}
