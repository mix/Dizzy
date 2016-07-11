//
//  ViewController.swift
//  DizzySample
//
//  Created by Robert Otani on 7/9/16.
//  Copyright © 2016 Robert Otani. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var dizzyActivityIndicator: DizzyActivityIndicatorView!
    @IBOutlet weak var hiddenStateToggle: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hiddenStateToggle.on = dizzyActivityIndicator.hidesWhenStopped
    }
    
    @IBAction func didTapToggleButton(sender: UIButton) {
        if dizzyActivityIndicator.isAnimating {
            dizzyActivityIndicator.stopAnimating()
        } else {
            dizzyActivityIndicator.startAnimating()
        }
    }
    
    @IBAction func didTapHiddenToggle(toggle: UISwitch) {
        dizzyActivityIndicator.hidesWhenStopped = toggle.on
    }
    
}

extension CALayer {
    var borderUIColor: UIColor {
        get {
            return UIColor(CGColor: borderColor!)
        } set {
            borderColor = newValue.CGColor
        }
    }
}
