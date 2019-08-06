//
//  GpaPersistance.swift
//  TritonCalc
//
//  Created by Josh Hollandsworth on 8/5/19.
//  Copyright © 2019 Joshholl. All rights reserved.
//

import Foundation

protocol GpaPersistable{
    var actualizedGpa: GradePointAverage {get}
    func save(gpa: GradePointAverage)
    
    var courseProjections: CourseList {get}
    func save(course: Course)
    func remove(course: Course)
}

final class GpaPersistence: GpaPersistable {
    var actualizedGpa: GradePointAverage
    
    func save(gpa: GradePointAverage) {
        actualizedGpa = gpa
    }
    
    var courseProjections: CourseList
    
    func save(course: Course) {
        self.courseProjections.append(course)
    }
    
    func remove(course: Course) {
        if let index = courseProjections.firstIndex(of: course) {
            courseProjections.remove(at: index)
        }
    }
    
    init() {
        self.actualizedGpa = GradePointAverage.default
        self.courseProjections = CourseList()
    }
    
    
}
