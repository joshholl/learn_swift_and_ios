import Foundation
import UIKit

final class CourseListTableViewCell : UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var creditHoursLabel: UILabel!
    @IBOutlet weak var letterGradeLabel: UILabel!
    @IBOutlet weak var gradePointsLabel: UILabel!
    
    private(set) var course: Course!
    
    private var hoursString: String {
        return self.course.creditHours == 1 ? "\(course.creditHours) Hour" : "\(course.creditHours) Hours"
    }
    
    private var displayableLetterGrade: String {
        return self.course.grade ?? "None"
    }
    
    func forCourse(_ course: Course) {
        self.course = course
        
        nameLabel.text = self.course.name
        creditHoursLabel.text = hoursString
        gradePointsLabel.text = self.course.points.asString()
        letterGradeLabel.text = displayableLetterGrade

    }
}
