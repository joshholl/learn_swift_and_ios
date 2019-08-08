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

extension GradePointAverage {
    static func from(_ entity: CurrentGpaEntity? ) -> GradePointAverage {
        
        guard let safeEntity = entity else {
            return GradePointAverage.default
        }
        
        let hours = Int(safeEntity.hours)
        let points = safeEntity.pointsEarned
        
        return GradePointAverage(hours: hours, pointsEarned: points)
    }
}

extension GradePointAverage {
    static func +(left: GradePointAverage, right: GradePointAverage) -> GradePointAverage {
        let hours = left.hours + right.hours
        let points = left.pointsEarned  + right.pointsEarned
        
        return GradePointAverage(hours: hours, pointsEarned: points)
    }
}

extension GradePointAverage: Equatable {
    static func == (lhs: GradePointAverage, rhs: GradePointAverage) -> Bool {
        return lhs.hours == rhs.hours && lhs.pointsEarned == rhs.pointsEarned
    }
}
