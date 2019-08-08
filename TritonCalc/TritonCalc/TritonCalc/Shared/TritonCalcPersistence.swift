//
//  TritonCalcPersistence.swift
//  TritonCalc
//
//  Created by Josh Hollandsworth on 8/6/19.
//  Copyright © 2019 Joshholl. All rights reserved.
//

import Foundation
import CoreData
import UIKit

final class TritonCalcPersistence {
    var coureses: CourseList {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            Log.error("Could not locate AppDelegate")
            return []
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchCourseEntities = NSFetchRequest<CourseEntity>(entityName: "CourseEntity")
        
        var result: CourseList = []
        managedContext.performAndWait {
            do {
                let coureseEntities = try managedContext.fetch(fetchCourseEntities)
                result = Course.from(coureseEntities)
                
                Log.info("Successfully retrieved \(result.count) enititie(s)")
            } catch {
                Log.error(error)
            }
        }
        
        return result
    }
    
    
    var currentGpa: GradePointAverage {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            Log.error("Could not locate AppDelegate")
            return GradePointAverage.default
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchCurrentGpa = NSFetchRequest<CurrentGpaEntity>(entityName: "CurrentGpaEntity")
        
        var result: GradePointAverage = GradePointAverage.default
        managedContext.performAndWait {
            do {
                let gpaEntities = try managedContext.fetch(fetchCurrentGpa)
                var entity = gpaEntities.first
                if entity == nil {
                    entity =  CurrentGpaEntity(context: managedContext)
                    entity?.hours = 0
                    entity?.pointsEarned = 0
                    try managedContext.save()
                }
                result = GradePointAverage.from(entity)
                
                Log.info("Successfully retrieved \(gpaEntities.count) enititie(s)")
            } catch {
                Log.error(error)
            }
        }
        
        return result
    }
    
    func delete(course: Course) {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                Log.error("Could not locate AppDelegate")
                return
            }
            
            self.delete(course: course, withAppDelegate: appDelegate)
    }
    
    func save(course: Course) {
        DispatchQueue.main.async { [weak self] in
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                Log.error("Could not locate AppDelegate")
                return
            }
            
            self?.save(course: course, withAppDelegate: appDelegate)
        }
    }
    
    func save(gpa: GradePointAverage) {
        DispatchQueue.main.async { [weak self] in
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                Log.error("Could not locate AppDelegate")
                return
            }
            
            self?.save(gpa: gpa, withAppDelegate: appDelegate)
        }
    }
}

extension TritonCalcPersistence {
    private func save(course: Course, withAppDelegate appDelegate: AppDelegate) {
        let managedContext = appDelegate.persistentContainer.viewContext
        
        do {
            //find existing course
            let fetchEntity = NSFetchRequest<CourseEntity>(entityName: "CourseEntity")
            fetchEntity.predicate = NSPredicate(format: "%K == %@", "id", course.id as CVarArg)
            var entity = try managedContext.fetch(fetchEntity).first
            
            if entity == nil {
                entity = CourseEntity(context: managedContext)
                entity?.id = course.id
            }
            
            entity?.name = course.name
            entity?.creditHours = Int32(course.creditHours)
            entity?.isSubstitute = course.isSubstitue ?? false
            entity?.letterGrade = course.grade
            entity?.previousLetterGrade = course.previousGrade
            
            try managedContext.save()
            Log.info("Successfully saved \(course.name)")
        } catch {
            Log.error(error)
        }
    }
   
    private func save(gpa: GradePointAverage, withAppDelegate appDelegate: AppDelegate) {

        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        do {
            //find existing course
            let fetchEntity = NSFetchRequest<CurrentGpaEntity>(entityName: "CurrentGpaEntity")
            var entity = try managedContext.fetch(fetchEntity).first
            
            if entity == nil {
                entity = CurrentGpaEntity(context: managedContext)
            }
            
            entity?.hours = Int16(gpa.hours)
            entity?.pointsEarned = gpa.pointsEarned
            
            
            try managedContext.save()
            Log.info("Successfully saved current gpa")
        } catch {
            Log.error(error)
        }
    }
    
    private func delete(course: Course, withAppDelegate appDelegate: AppDelegate) {
        let managedContext = appDelegate.persistentContainer.viewContext
        
        do {
            //find existing course
            let fetchEntity = NSFetchRequest<CourseEntity>(entityName: "CourseEntity")
            fetchEntity.predicate = NSPredicate(format: "%K == %@", "id", course.id as CVarArg)
            
            guard let entity = try managedContext.fetch(fetchEntity).first else {
                Log.info("Could not find course \(course.name) to delete")
                return
            }
            
            managedContext.delete(entity)
            
            try managedContext.save()
            Log.info("Successfully deleted \(course.name)")
        } catch {
            Log.error(error)
        }
    }
}


