//
//  CourseListModel.swift
//  TritonCalc
//
//  Created by Josh Hollandsworth on 8/3/19.
//  Copyright © 2019 Joshholl. All rights reserved.
//

import Foundation
import UIKit

final class CourseList {
    private var courses: [Course]
    private(set) var name: String
    
    var count : Int {
        return courses.count
    }
    
    var totalHours: Int {
        return courses.reduce(0, { sum, next in sum + next.creditHours })
    }
    
    
    init(name: String) {
        self.courses = []
        self.name = name
    }
    
    func courseAt(index: Int) -> Course? {
        guard index >= 0 && index < count else {
            return nil
        }
        return courses[index]
    }
}


protocol CourseListCollectionModelDelegate: class {
    func courseListChanged(courseListIndex: Int)
}


final class CourseListCollectionModel {
    private var courseLists: [CourseList]
    private weak var delegate: CourseListCollectionModelDelegate?
    
    var numberOfLists: Int {
        return courseLists.count
    }
    
    init(delegate: CourseListCollectionModelDelegate) {
        self.delegate = delegate
        courseLists = [CourseList(name: "Completed Courses"), CourseList(name: "Projected/In Progress Courses")]
    }
    
    func listAt(index: Int) -> CourseList? {
        guard index >= 0 && index < numberOfLists else {
            return nil
        }
        return courseLists[index]
    }
    
}
