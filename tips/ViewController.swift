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
        
        billField.becomeFirstResponder()
        
        tipLabel.text = currencyFormatter.stringFromNumber(0)
        totalLabel.text = currencyFormatter.stringFromNumber(0)

        let locale = NSLocale.preferredLanguages()
        println("the preferred lanugage is \(locale)")

        
        updateDefaultBillAmount()
        updateDefaultTipControl()
    }
    
    // format the currency to a native currency
    var currencyFormatter: NSNumberFormatter {
        let formatter = NSNumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        return formatter
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
        let formatter = NSNumberFormatter()
        formatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        var localeIdentifier = (formatter.stringFromNumber(1234.5678))

            
        var tipPercentages = [0.18, 0.20, 0.22]
        var tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
        
        var billAmount = NSString(string: billField.text).doubleValue
        var tip = billAmount * tipPercentage
        var total = billAmount + tip


        tipLabel.text = "$\(tip)"
        totalLabel.text = "$\(total)"

        tipLabel.text = currencyFormatter.stringFromNumber(tip) //String(format: "$%.2f", tip)
        totalLabel.text = (currencyFormatter.stringFromNumber(total))//String(format: "$%.2f", total)
        
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

