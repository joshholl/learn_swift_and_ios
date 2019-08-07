import Foundation

protocol GpaOverviewDelegate: class {
    func update(to: GradePointAverage)
}

class GpaOverviewModel {
    
    private weak var delegate: ModelRefreshDelegate?
    private var persistence: TritonCalcPersistence
    private var courses: CourseList
    private(set) var currentGpa: GradePointAverage
    var projectedGpa: GradePointAverage {
        get {
            return courses.gpa
        }
        
    }
    var projectedHoursInProgress: Int {
        get {
            return courses.inProgressHours
        }
    }
    init(persistence: TritonCalcPersistence, delegate: ModelRefreshDelegate) {
        self.persistence = persistence;
        self.delegate = delegate
        self.courses = []
        self.currentGpa = GradePointAverage.default
        
        
    }
    
    func getData() {
        self.courses = self.persistence.coureses
        self.currentGpa = self.persistence.currentGpa
        self.delegate?.refresh()
    }
    
    
    
    func update(actualized: GradePointAverage) {
        self.persistence.save(gpa: actualized)
        self.delegate?.refresh()
    }
}
