import Foundation
import UIKit

final class CourseListTableViewCell : UITableViewCell {
    
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var creditHours: UILabel!
    @IBOutlet private weak var letterGrade: UILabel!
    @IBOutlet private weak var points: UILabel!
    
    
    private(set) var course: Course!
    
    func forCourse(_ course: Course) {
        self.course = course
        
        self.nameLabel.text = course.name
        self.creditHours.text = "\(course.creditHours)"
        self.letterGrade.text = String(format: "%.1f %s", course.grade.rawValue.pointValue, course.grade.rawValue.letter)
        self.points.text = String(format: "%.1f", course.points)
    }
    
}
