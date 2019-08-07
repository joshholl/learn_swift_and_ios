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
    @IBOutlet weak var projectedHoursInProgress: UILabel!
}

extension OverviewViewController {
    override func viewDidLoad() {
        model = GpaOverviewModel(persistence: TritonCalcPersistence(), delegate: self)
        refresh()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "showCurrentGpa") {
            guard let target = segue.destination as? CurrentGpaViewController else {
                return
            }
            target.prepare(model: model.currentGpa, delegate: self)
        } 
    }
}

extension OverviewViewController: ModelRefreshDelegate {
    func refresh() {
        actualHoursCompleted.text = "\(model.currentGpa.hours)"
        actualPointsEarned.text = model.currentGpa.pointsEarned.asString()
        actualGPA.text = model.currentGpa.average.asString()
        projectedHoursCompleted.text = "\(model.projectedGpa.hours)"
        projectedHoursInProgress.text = "\(model.projectedHoursInProgress)"
        projectedPointsEarned.text = model.projectedGpa.pointsEarned.asString()
        projectedGPA.text = model.projectedGpa.average.asString()
    }
}


extension OverviewViewController: GpaOverviewDelegate {
    func update(to newAverage: GradePointAverage) {
        model.update(actualized: newAverage)
    }
}
