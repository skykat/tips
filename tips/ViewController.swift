//
//  ViewController.swift
//  tips
//
//  Created by Karen Levy on 4/13/15.
//  Copyright (c) 2015 Karen Levy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
        
        updateDefaultBillAmount()
        updateDefaultTipControl()
    }
    
    // update the default percentage from the settings page
    private func updateDefaultTipControl() {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        tipControl.selectedSegmentIndex = userDefaults.integerForKey("percentage_preference")
    }
    
    // update the default bill amount upon app restart
    private func updateDefaultBillAmount() {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        billField.text = userDefaults.stringForKey("bill_amount")

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onEditingChanged(sender: AnyObject) {
        
        var tipPercentages = [0.18, 0.20, 0.22]
        var tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
        
        var billAmount = NSString(string: billField.text).doubleValue
        var tip = billAmount * tipPercentage
        var total = billAmount + tip

        tipLabel.text = "$\(tip)"
        totalLabel.text = "$\(total)"
        
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
        
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setValue(billField.text, forKey: "bill_amount")
    }

    @IBAction func launchSettings(sender: AnyObject) {
        let settingsUrl = NSURL(string: UIApplicationOpenSettingsURLString)
        UIApplication.sharedApplication().openURL(settingsUrl!)
    }
    
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
}

