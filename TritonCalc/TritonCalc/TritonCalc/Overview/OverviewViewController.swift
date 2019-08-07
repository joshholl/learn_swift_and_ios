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
    
    @IBOutlet weak var mainStackView: UIStackView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
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
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "showCurrentGpa") {
            guard let target = segue.destination as? CurrentGpaViewController else {
                return
            }
            target.prepare(model: model.currentGpa, delegate: self)
        } 
    }
    override func viewWillAppear(_ animated: Bool) {
        mainStackView.isHidden = true
        activityIndicator.startAnimating()
        model.getData()
    }
}

extension OverviewViewController: ModelRefreshDelegate {
    func refresh() {
        DispatchQueue.main.async { [weak self] in
            
            guard let model = self?.model else {
                self?.mainStackView.isHidden = false
                self?.activityIndicator?.stopAnimating()
                return
            }
            
            self?.actualHoursCompleted.text = "\(model.currentGpa.hours)"
            self?.actualPointsEarned.text = model.currentGpa.pointsEarned.asString()
            self?.actualGPA.text = self?.model.currentGpa.average.asString()
            self?.projectedHoursCompleted.text = "\(model.projectedGpa.hours)"
            self?.projectedHoursInProgress.text = "\(model.projectedHoursInProgress)"
            self?.projectedPointsEarned.text = model.projectedGpa.pointsEarned.asString()
            self?.projectedGPA.text = model.projectedGpa.average.asString()
            
            self?.mainStackView.isHidden = false
            self?.activityIndicator.stopAnimating()
        }
    }
}


extension OverviewViewController: GpaOverviewDelegate {
    func update(to newAverage: GradePointAverage) {
        model.update(actualized: newAverage)
    }
}
