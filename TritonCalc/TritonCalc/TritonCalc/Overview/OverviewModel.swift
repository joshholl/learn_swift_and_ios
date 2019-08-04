//
//  OverviewModel.swift
//  TritonCalc
//
//  Created by Josh Hollandsworth on 8/4/19.
//  Copyright © 2019 Joshholl. All rights reserved.
//

import Foundation


protocol ActualizedGpaUpdateDelegate: class {
    func update(to: GradePointAverage)
}

class GpaOverviewModel {
    private(set) var actualizedGPA : GradePointAverage;
    private(set) var projectedGPA: GradePointAverage;
    init() {
        self.actualizedGPA = GradePointAverage(hours: 0 ,pointsEarned:   0)
        self.projectedGPA = GradePointAverage(hours: 0, pointsEarned: 0)
    }
    
    func update(actualized: GradePointAverage) {
        self.actualizedGPA = actualized
    }
}
