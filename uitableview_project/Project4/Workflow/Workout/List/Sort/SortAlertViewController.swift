
import Foundation
import UIKit

protocol WorkoutListSortDelegate {
    func sort(withOption: SortOption) -> Void
}

typealias ActionHandler = ((UIAlertAction) -> Void)

extension UIAlertController {
    func setupForSort( handler sortHandler: WorkoutListSortDelegate) {

      SortOption.allCases
        .map{ opt in (name: opt.rawValue, handler: { (handler) in sortHandler.sort(withOption: opt)})}
        .forEach{ self.addAction(UIAlertAction(title: $0.name, style: .destructive, handler: $0.handler)) }
    }
}


