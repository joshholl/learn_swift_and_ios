import Foundation
import CoreData

protocol GpaOverviewDelegate: class {
    func update(to: GradePointAverage)
}

class GpaOverviewModel {

    private weak var delegate: ModelRefreshDelegate?
    private var persistence: TritonCalcPersistence
    private var courses: CourseList
    private(set) var currentGpa: GradePointAverage
    var projectedGpa: GradePointAverage {
        return courses.gpa
    }
    
    init(persistence: TritonCalcPersistence, delegate: ModelRefreshDelegate) {
        self.persistence = persistence;
        self.delegate = delegate
        
        self.courses = self.persistence.coureses
        self.currentGpa = self.persistence.currentGpa
    }
    
    func update(actualized: GradePointAverage) {
        self.persistence.save(gpa: actualized)
        self.delegate?.refresh()
    }
    
//    func refresh() {
//        let fetchCourseList = NSFetchRequest<Course>(entityName: "Course")
//        self.courses = try! context.fetch(fetchCourseList)
//
//        let fetchCurrentGpa = NSFetchRequest<CurrentGpa>(entityName: "CurrentGpa")
//        guard let gpa = try! context.fetch(fetchCurrentGpa).first else {
//            self.currentGpa = CurrentGpa(context: self.context)
//            try! context.save()
//            return
//        }
//        self.currentGpa = gpa
//    }
}
