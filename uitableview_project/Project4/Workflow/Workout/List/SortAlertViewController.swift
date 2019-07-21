
import Foundation
import UIKit

protocol WorkoutListSortDelegate {
    func sort(withOption: SortOption) -> Void
}

typealias ActionHandler = ((UIAlertAction) -> Void)

func createAlertForSort (handler sortHandler: WorkoutListSortDelegate) -> UIAlertController {
    let alert = UIAlertController(title: "Sorting", message: "How would you like to sort", preferredStyle: .actionSheet)
    
    SortOption.allCases
        .map{ opt in (name: opt.rawValue, handler: { (handler) in sortHandler.sort(withOption: opt)})}
        .forEach{ alert.addAction(UIAlertAction(title: $0.name, style: .destructive, handler: $0.handler)) }
    
    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
    return alert;
}

func createAlertForDeleteAll(handler: @escaping ActionHandler) -> UIAlertController {
    let alertController = UIAlertController(title: "Delete All Workouts", message: "Confirm", preferredStyle: .alert)
    alertController.addAction( UIAlertAction(title: "Yes", style: .default, handler: handler))
        alertController.addAction( UIAlertAction(title: "Cancel", style: .cancel ))
    return alertController
}

func createAlertForDeleteWorkout(named: String, handler: @escaping ActionHandler) -> UIAlertController {
    let alertController = UIAlertController(title: "Delete workout name \(named)?", message: "Confirm", preferredStyle: .alert)
    alertController.addAction( UIAlertAction(title: "Yes", style: .default, handler: handler))
    alertController.addAction( UIAlertAction(title: "Cancel", style: .cancel ))
    return alertController
}
