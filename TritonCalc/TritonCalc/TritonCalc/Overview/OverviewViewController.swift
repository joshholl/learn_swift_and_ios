//
//  OverviewViewController.swift
//  TritonCalc
//
//  Created by Josh Hollandsworth on 8/4/19.
//  Copyright © 2019 Joshholl. All rights reserved.
//

import Foundation
import UIKit


class OverviewViewController: UIViewController {
    var model: GpaOverviewModel!
    
    @IBOutlet weak var actualHoursCompleted: UILabel!
    @IBOutlet weak var actualPointsEarned: UILabel!
    @IBOutlet weak var actualGPA: UILabel!
    @IBOutlet weak var projectedHoursCompleted: UILabel!
    @IBOutlet weak var projectedPointsEarned: UILabel!
    @IBOutlet weak var projectedGPA: UILabel!
}

extension OverviewViewController {
    override func viewDidLoad() {
        model = GpaOverviewModel()
        
        actualHoursCompleted.text = "\(model.actualizedGPA.hours)"
        actualPointsEarned.text = model.actualizedGPA.pointsEarned.asString()
        actualGPA.text = model.actualizedGPA.average.asString()
        projectedHoursCompleted.text = "\(model.projectedGPA.hours)"
        projectedPointsEarned.text = model.projectedGPA.pointsEarned.asString()
        projectedGPA.text = model.projectedGPA.average.asString()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "showCurrentGpa") {
            guard let target = segue.destination as? CurrentGpaViewController else {
                return
            }
            target.prepare(model: model.actualizedGPA, delegate: self)
        }
    }
}

extension OverviewViewController: ActualizedGpaUpdateDelegate {
    func update(to newAverage: GradePointAverage) {
        model.update(actualized: newAverage)
        
        actualHoursCompleted.text = "\(model.actualizedGPA.hours)"
        actualPointsEarned.text = model.actualizedGPA.pointsEarned.asString()
        actualGPA.text = model.actualizedGPA.average.asString()
    }
}
