import Foundation

final class CourseUpsertModel {
    private(set) var letterGrades: [String]
    private var course: Course?
    
    private var persistence: TritonCalcPersistence
    private weak var delegate: ModelRefreshDelegate?
    
    let minCourseHoursStepper: Double = 1
    let maxCourseHoursStepper: Double = 5
    let courseHoursStepperSize: Double = 1
    let courseHoursStepperDefault: Int = 3
    
    let noneGradeValue: String = "None"
    let saveButtonText: String
    let replaceableLetterGrades = ["None", "C-", "D+", "D", "D-", "F", "FN" ]
    
    var name: String?
    var projectedGrade: String?
    var previousGrade: String?
    var isSubstitute: Bool?
    var hours: Int?
    
    init(course: Course?, persistence: TritonCalcPersistence, delegate: ModelRefreshDelegate) {
        self.delegate = delegate
        self.persistence = persistence
        
        letterGrades = [noneGradeValue]
        letterGrades.append(contentsOf: LetterGradeHelper.orderedGrades)
        
        self.saveButtonText = course != nil ? "Update Course" : "Add Course"
        self.course = course
        self.name = course?.name
        self.projectedGrade = course?.grade
        self.previousGrade = course?.previousGrade
        self.isSubstitute = course?.isSubstitue
        self.hours = course?.creditHours ?? courseHoursStepperDefault
    }
}

// MARK: Validations
extension CourseUpsertModel {
    
    func isNameValid(_ string: String?) -> Bool {
        guard let value = string else {
            return false
        }
        return !value.isEmpty
    }
    
    func isPreviousGradeValid(_ string: String?) -> Bool {
        return false
    }
    
    func canSave() -> Bool {
        let areGradesSubstituting = self.isSubstitute ?? false
        let previousGradeIsValid = (areGradesSubstituting && previousGrade != nil) || (!areGradesSubstituting && (previousGrade == "None" || previousGrade == nil))
        
        return isNameValid(self.name) && previousGradeIsValid
    }
    
}


extension CourseUpsertModel {
    func save() {
        guard canSave() == true else {
            return
        }
        
        let id = course?.id ?? UUID()
        let updated = Course(id: id, name: self.name!,
                             creditHours: self.hours!,
                             isSubstitue: self.isSubstitute,
                             grade: self.projectedGrade,
                             previousGrade: self.previousGrade
        )
        
        
        
        
        //was updating
        
        func defaultOf(bool: Bool?) -> Bool { return bool ?? false }
        
        
        
        let currentGpa = self.persistence.currentGpa
        var newGpa: GradePointAverage?
        if(self.course == nil && defaultOf(bool: updated.isSubstitue)) { // is this a new course and is it substituting
            let newHours = currentGpa.hours - updated.creditHours
            let newPoints = currentGpa.pointsEarned - updated.previousPoints
            newGpa = GradePointAverage(hours: newHours, pointsEarned: newPoints)
        } else if (defaultOf(bool: updated.isSubstitue)) {              //is updated substituting
            if(defaultOf(bool: course?.isSubstitue)) {                  //was previous substituting
                let newHours = currentGpa.hours + (course?.creditHours ?? 0) - updated.creditHours
                let newPoints = currentGpa.pointsEarned + (course?.previousPoints ?? 0.0) - updated.previousPoints
                newGpa = GradePointAverage(hours: newHours, pointsEarned: newPoints)
            } else {
                let newHours = currentGpa.hours - updated.creditHours
                let newPoints = currentGpa.pointsEarned - updated.previousPoints
                newGpa = GradePointAverage(hours: newHours, pointsEarned: newPoints)
            }
        } else if (defaultOf(bool: course?.isSubstitue)) {              // was updating (but isn't anymore)
            let newHours = currentGpa.hours + (course?.creditHours ?? 0)
            let newPoints = currentGpa.pointsEarned + (course?.previousPoints ?? 0.0)
            newGpa = GradePointAverage(hours: newHours, pointsEarned: newPoints)
        }
        
    
        if let updatedGpa = newGpa {
            self.persistence.save(gpa: updatedGpa)
        }
        
        self.persistence.save(course: updated)
        delegate?.refresh()
        
        
    }
    func selectedLetterGradeIndex(isForSubstitution: Bool) -> Int {
        let options = isForSubstitution ? self.replaceableLetterGrades : self.letterGrades
        let grade = isForSubstitution ? self.course?.previousGrade : self.course?.grade
        return options.firstIndex(of: grade ?? noneGradeValue)!
        
    }
    
}

