//
//  CourseList.swift
//  TritonCalc
//
//  Created by Josh Hollandsworth on 8/6/19.
//  Copyright © 2019 Joshholl. All rights reserved.
//

import Foundation
typealias CourseList = [Course]

extension CourseList {
        var totalHours: Int {
            return self.reduce(0, { sum, next in sum + next.creditHours })
        }
    
        var gpa: GradePointAverage {
            get {
            let applicableCourses = self.filter{$0.grade != nil}
    
            return GradePointAverage(hours: self.totalHours,
                                     pointsEarned: applicableCourses.reduce(0, {sum, next in sum + next.points}))
            }
        }
}
