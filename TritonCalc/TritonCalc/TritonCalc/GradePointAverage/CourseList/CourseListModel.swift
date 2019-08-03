//
//  CourseListModel.swift
//  TritonCalc
//
//  Created by Josh Hollandsworth on 8/3/19.
//  Copyright © 2019 Joshholl. All rights reserved.
//

import Foundation
import UIKit

protocol CourseListModelDelegate: class {
    func coursesUpdated()
}

final class CourseListModel {
    private var projected: [Course]
    private var actualized: [Course]
    private weak var delegate: CourseListModelDelegate?
    
    init(delegate: CourseListModelDelegate) {
        self.delegate = delegate
        
        projected = []
        actualized = []
    }
}
