//
//  OverviewModel.swift
//  TritonCalc
//
//  Created by Josh Hollandsworth on 8/4/19.
//  Copyright © 2019 Joshholl. All rights reserved.
//

import Foundation


protocol GpaOverviewDelegate: class {
    func update(to: GradePointAverage)
    func refresh()
}

class GpaOverviewModel {
    private let persistence: GpaPersistable
    private(set) var actualizedGPA : GradePointAverage;
    private(set) var projectedGPA: GradePointAverage;
    init() {
        self.persistence = ApplicationSession.sharedInstance.persistence
        self.actualizedGPA = persistence.actualizedGpa
        self.projectedGPA = persistence.courseProjections.gpa
    }
    
    func update(actualized: GradePointAverage) {
        persistence.save(gpa: actualized)
    }
    
    func refresh() {
        self.actualizedGPA = persistence.actualizedGpa
        self.projectedGPA = persistence.courseProjections.gpa
    }
}
