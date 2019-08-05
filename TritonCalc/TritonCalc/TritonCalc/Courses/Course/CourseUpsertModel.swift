//
//  CourseUpsertModel.swift
//  TritonCalc
//
//  Created by Josh Hollandsworth on 8/4/19.
//  Copyright © 2019 Joshholl. All rights reserved.
//

import Foundation

protocol CourseUpsertModelDelegate: class {
    func save(course: Course)
}

final class CourseUpsertModel {
    
    private(set) var course: Course
    private weak var delegate: CourseUpsertModelDelegate?
    
    let minCourseHoursStepper: Double = 1
    let maxCourseHoursStepper: Double = 5
    let courseHoursStepperSize: Double = 1
    private(set) var letterGrades: [String]
    
    
    init(course: Course?, delegate: CourseUpsertModelDelegate) {
        self.course = course ?? Course.default
        letterGrades = ["None"]
        letterGrades.append(contentsOf: LetterGrade.allCases.map({$0.rawValue.letter}))
        self.delegate = delegate
    }
}

extension CourseUpsertModel {
    func save(name: String, hours: Int, grade: String) {
        
        // init of the rawValue with a string thats isn't mapped will return nil, thats ok here
        let letterGrade = LetterGrade.init(rawValue: Grade(letter: grade, pointValue: 0))
        delegate?.save(course: Course(name: name, creditHours: hours, grade: letterGrade))
    }
}

