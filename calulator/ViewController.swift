//
//  ViewController.swift
//  calulator
//
//  Created by Gurpal Bhoot on 10/30/18.
//  Copyright © 2018 Gurpal Bhoot. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // IB-Outlets
    @IBOutlet weak var outputLabel: UILabel!

    
    // Variables
    var outputValue : Int = 0
    var outputStr = ""
    // true means we are on second output
    var nextOutput = false
    // true means display negative value
    var posNeg = false
    // true when decimal has been pressed
    var decPressed = false
    var firstOperation = true
    var currentOperation = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setupView()
    }
    
    func setupView() {
        updateOutputLabel(numOrString: true)
    }
    
    func updateOutputLabel(numOrString: Bool) {
        if numOrString {
            outputLabel.text = "\(outputValue)"
        } else {
            outputLabel.text = outputStr
        }
    }
    
    func prepareOperation(operation: String) {
        var numOrString = false
        switch operation {
        case "AC":
            decPressed = false
            numOrString = true
            clearOperation()
        case "/":
            print("Division")
            nextOutput = true
            numOrString = true
            performOperation(operation: operation)
            currentOperation = operation
        case "X":
            print("Multiplication")
            nextOutput = true
            numOrString = true
            performOperation(operation: operation)
            currentOperation = operation
        case "-":
            print("Subtraction")
            nextOutput = true
            numOrString = true
            performOperation(operation: operation)
            currentOperation = operation
        case "+":
            print("Addition")
            nextOutput = true
            numOrString = true
            performOperation(operation: operation)
            currentOperation = operation
        case "=":
            print("Equals")
            nextOutput = false
            numOrString = true
            performEquals()
            return
        case "+/-":
            print("Sign Change")
            changeSign()
        case "%":
            print("Percentage")
        case ".":
            print("Decimal")
            if decPressed {
                break
            } else {
                decPressed = true
            }
        default:
                outputStr.append(operation)
        }
        
        updateOutputLabel(numOrString: numOrString)
    }
    
    func changeSign() {
        if posNeg == true {
            posNeg = false
                outputStr = String(outputStr.dropFirst())
        } else {
            posNeg = true
                outputStr = "-" + outputStr
        }
    }
    
    func performOperation(operation: String) {
        if firstOperation {
            firstOperation = false
            if let output = Int(outputStr) {
                print(output)
                outputValue = output
                outputStr = ""
            }
        } else {
            if let output = Int(outputStr) {
                switch currentOperation {
                case "/":
                    outputValue /= output
                case "*":
                    outputValue *= output
                case "+":
                    outputValue += output
                case "-":
                    outputValue -= output
                default:
                    outputValue = output
                }
            }
            outputStr = ""
        }
    }
    
    func performEquals() {
        if !firstOperation {
            performOperation(operation: currentOperation)
            updateOutputLabel(numOrString: true)
            firstOperation = true
            currentOperation = ""
        }
        outputValue = 0
        nextOutput = false
    }

    func clearOperation() {
        outputValue = 0
        outputStr = ""
        firstOperation = true
        currentOperation = ""
        nextOutput = false
    }
    
    func toggleDecimal() {
        if decPressed {
            decPressed = false
        } else {
            decPressed = true
        }
    }
    
    // IB-Actions
    @IBAction func calcBtnPressed(_ sender: Any) {
        if let button = sender as? UIButton {
            if let title = button.titleLabel?.text {
                if nextOutput {
                    prepareOperation(operation: title)
                } else {
                    prepareOperation(operation: title)
                }
            }
        }
    }
}

