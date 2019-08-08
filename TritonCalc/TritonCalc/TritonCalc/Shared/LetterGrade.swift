//
//  LetterGrade.swift
//  TritonCalc
//
//  Created by Josh Hollandsworth on 8/4/19.
//  Copyright © 2019 Joshholl. All rights reserved.
//

import Foundation

struct Grade {
    let letter: String
    let pointValue: Double
}



struct LetterGradeHelper {
    static private let gradeDictionary: [String: Double] =
        ["A": 4.0, "A-":  3.7, "B+": 3.3,"B": 3,"B-": 2.7,"C+": 2.3,"C": 2,"C-": 1.7,"D+": 1.3,"D": 1,"D-": 0.7,"F": 0,"FN": 0]
    static let orderedGrades: [String] =  ["A", "A-", "B+","B","B-","C+","C","C-","D+","D","D-","F","FN"]
    
    static func pointsForGrade(grade: String?) -> Double {
        guard let letterGrade = grade else {
            return 0
        }
        return gradeDictionary[letterGrade] ?? 0
    }
    
}
