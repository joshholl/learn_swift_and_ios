import Foundation

final class CourseUpsertModel {
    
    private(set) var course: Course?
    private var persistence: TritonCalcPersistence
    private weak var delegate: ModelRefreshDelegate?
    
    let minCourseHoursStepper: Double = 1
    let maxCourseHoursStepper: Double = 5
    let courseHoursStepperSize: Double = 1
    let noneGradeValue: String = "None"
    let saveButtonText: String
    
    private(set) var letterGrades: [String]
    
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
    func save(name: String, hours: Int, grade: String, isSubstitue: Bool = false) {
        
        let id = course?.id ?? UUID()
        let grade = LetterGrade.from(string: grade)
        let updatedCourse = Course(id: id, name: name, creditHours: hours, isSubstitue: isSubstitue, grade: grade)
        
        self.persistence.save(course: updatedCourse)
        delegate?.refresh()
    }
    
    func selectedLetterGradeIndex() -> Int{
        guard let grade = self.course?.grade?.rawValue.letter else {
            return self.letterGrades.firstIndex(of: noneGradeValue)!
        }

        return self.letterGrades.firstIndex(of: grade)!
    }
}

