//
//  GradePointAverage.swift
//  TritonCalc
//
//  Created by Josh Hollandsworth on 8/4/19.
//  Copyright © 2019 Joshholl. All rights reserved.
//

import Foundation

struct GradePointAverage {
    let hours: Int
    let pointsEarned: Double
    var average: Double {
        guard hours > 0 && pointsEarned > 0 else {
            return 0
        }
        return pointsEarned / Double(hours)
    
    }
    
    init(hours: Int, average: Double) {
        self.hours = hours
        self.pointsEarned = average * Double(hours)
    }
    
    init(hours: Int, pointsEarned: Double) {
        self.hours = hours
        self.pointsEarned = pointsEarned
    }
}

extension GradePointAverage {
    static var `default` : GradePointAverage {
        return GradePointAverage(hours: 0, pointsEarned: 0 )
    }
    

}
