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
}

protocol CourseListModelDelegate {
    func dataRefreshed()
}


final class CourseListModel {
    private var courseList: CourseList
    private var delegate: CourseListModelDelegate
    var count: Int { return courseList.count }
    let rowHeight: Double = 64.0
    
    init(delegate: CourseListModelDelegate) {
        self.delegate = delegate
        self.courseList = CourseList()
    }
}

extension CourseListModel {
    func course(at index: Int) -> Course? {
        return courseList.element(at: index)
    }
}


extension CourseListModel: CourseUpsertModelDelegate {
    func save(course: Course) {
        courseList.append(course)
        delegate.dataRefreshed()
    }
}
