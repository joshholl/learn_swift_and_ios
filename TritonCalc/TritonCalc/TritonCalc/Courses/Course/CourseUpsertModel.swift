import Foundation

final class CourseUpsertModel {
    private(set) var letterGrades: [String]
    private(set) var course: Course?
    
    private var persistence: TritonCalcPersistence
    private weak var delegate: ModelRefreshDelegate?
    
    let minCourseHoursStepper: Double = 1
    let maxCourseHoursStepper: Double = 5
    let courseHoursStepperSize: Double = 1
    let noneGradeValue: String = "None"
    let saveButtonText: String
    let replaceableLetterGrades = [ "C-", "D+", "D", "D-", "F", "FN" ]

    
    init(course: Course?, persistence: TritonCalcPersistence, delegate: ModelRefreshDelegate) {
        self.delegate = delegate
        self.persistence = persistence
    
        letterGrades = [noneGradeValue]
        letterGrades.append(contentsOf: LetterGrade.allCases.map({$0.rawValue.letter}))
        
        self.saveButtonText = course != nil ? "Update Course" : "Add Course"
        self.course = course
    }
}



extension CourseUpsertModel {
    func save(name: String, hours: Int, grade: String, isSubstitue: Bool = false, previousGrade: String? = nil) {

        let id = course?.id ?? UUID()
        let grade = LetterGrade.from(string: grade)
        let previousGrade = LetterGrade.from(string: previousGrade)
        let updated = Course(id: id, name: name, creditHours: hours, isSubstitue: isSubstitue, grade: grade, previousGrade: previousGrade)

        self.persistence.save(course: updated)
        
        if(((course?.isSubstitue ?? false) != updated.isSubstitue) ||
                (course?.previousGrade != updated.previousGrade)) {
            
            let gpa = persistence.currentGpa
            let newHours = gpa.hours + (course?.creditHours ?? 0) - updated.creditHours
            let newPointsEarned = gpa.pointsEarned + (course?.points ?? 0.0) - updated.points
            let newGpa = GradePointAverage(hours: newHours, pointsEarned: newPointsEarned)
            self.persistence.save(gpa: newGpa)
        }
        self.persistence.save(course: updated)
        delegate?.refresh()
        
        
    }
    func selectedLetterGradeIndex(isForSubstitution: Bool) -> Int{
        
        if isForSubstitution {
            return self.replaceableLetterGrades.firstIndex(of: self.course?.previousGrade?.rawValue.letter ?? "") ?? 0
        } else {
            return self.letterGrades.firstIndex(of: self.course?.grade?.rawValue.letter ?? noneGradeValue)!
        }
    }
   
}

