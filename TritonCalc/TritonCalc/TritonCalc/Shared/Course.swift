import Foundation

struct Course {
    
    let id: UUID
    let name: String
    let creditHours: Int
    let isSubstitue: Bool?
    let grade: String?
    let previousGrade: String?
}

extension Course {
    var points: Double {
        get {
            return Double(creditHours) * LetterGradeHelper.pointsForGrade(grade: grade)
        }
    }
    
    var previousPoints: Double {
        get {
            return Double(creditHours) * LetterGradeHelper.pointsForGrade(grade: previousGrade)
        }
    }
}

extension Course {
    static func from(_ courseEntities: [CourseEntity]) -> [Course] {
        return courseEntities.compactMap { Course.from($0) }
    }
    
    static func from(_ courseEntity: CourseEntity) -> Course? {
        guard let id = courseEntity.id else { return nil }
        guard let name = courseEntity.name else { return nil }
        
        let creditHours = Int(courseEntity.creditHours)
        let isSubstitue = courseEntity.isSubstitute
        let letterGrade = courseEntity.letterGrade
        let previousGrade = courseEntity.previousLetterGrade
 
        return Course(id: id, name: name,
                      creditHours: creditHours, isSubstitue: isSubstitue, grade: letterGrade, previousGrade: previousGrade)
    }
}


extension Course: Equatable {
    public static func == (lhs: Course, rhs: Course) -> Bool {
        return lhs.name == rhs.name &&
            lhs.creditHours == rhs.creditHours &&
            lhs.grade == rhs.grade &&
            lhs.isSubstitue == rhs.isSubstitue
    }
}

