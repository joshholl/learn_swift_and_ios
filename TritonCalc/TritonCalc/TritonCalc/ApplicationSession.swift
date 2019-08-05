//
//  ApplicationSession.swift
//  TritonCalc
//
//  Created by Josh Hollandsworth on 8/5/19.
//  Copyright © 2019 Joshholl. All rights reserved.
//

import Foundation

class ApplicationSession {
    static let sharedInstance = ApplicationSession()
    var persistence: GpaPersistable
    
    private init() {
//        if let appStorageUrl = FileManager.default.createDirectoryInUserLibrary(atPath: "WorkoutApp"),
//            let persistence = WorkoutPersistence(atUrl: appStorageUrl, withDirectoryName: "workouts") {
//            self.persistence = persistence
//        }
        persistence = GpaPersistence()
    }
    
}
