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

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func didTapToggleButton(sender: UIButton) {
        if dizzyActivityIndicator.isAnimating {
            dizzyActivityIndicator.stopAnimating()
        } else {
            dizzyActivityIndicator.startAnimating()
        }
    }

}

