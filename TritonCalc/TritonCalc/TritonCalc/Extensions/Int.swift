//
//  Int.swift
//  TritonCalc
//
//  Created by Josh Hollandsworth on 8/4/19.
//  Copyright © 2019 Joshholl. All rights reserved.
//

import Foundation

extension Int {
    func hoursString() -> String {
       return self == 1 ? "\(self) Hour" : "\(self) Hours"
    }
}
