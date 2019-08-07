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
    
    var inProgressHours: Int {
        return inProgressCourses.totalHours
    }
    var gpa: GradePointAverage {
        return GradePointAverage(hours: completedCourses.totalHours, pointsEarned: completedCourses.pointsEarned)
    }
    
    private var inProgressCourses: CourseList {
        return self.filter({$0.grade == nil })
    }
    
    private var completedCourses: CourseList {
        return self.filter({$0.grade != nil })
    }
    
    private var pointsEarned: Double{
        return self.reduce(0, {sum, next in sum + next.points})
    }
}
