//
//  calculatorViewController.swift
//  DongDongLaboratory
//
//  Created by Doing on 2018/11/29.
//  Copyright © 2018年 Doing. All rights reserved.
//

import UIKit

enum OperationType{
    case add
    case subtract
    case multiply
    case divide
    case none
}

class calculatorViewController: UIViewController {
    @IBOutlet weak var lable: UILabel!
    var numberOnScreen:Double = 0
    var previousNumber:Double = 0
    var performingMath = false
    var opertion:OperationType = .none
    var startNew = true
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    @IBAction func backToManu(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func showRate(_ sender: UIButton) {
        let inputLable = lable.text
        performSegue(withIdentifier: "goToRateView", sender: inputLable)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToRateView"{
            if let rateview = segue.destination as? RateViewController{
                rateview.infoFromViewOne = sender as? Double
            }
        }
    }
    func makeOKNumberString(from number:Double){
        var okText: String
        
        if floor(number) == number{
            okText = "\(Int(number))"
        }else{
            okText = "\(number)"
        }
        if okText.count >= 10{
            okText = String(okText.prefix(10))
        }
        lable.text = okText
    }
    
    @IBAction func add(_ sender: UIButton) {
        lable.text = "+"
        opertion = .add
        performingMath = true
        previousNumber = numberOnScreen
    }
    @IBAction func subtract(_ sender: UIButton) {
        lable.text = "-"
        opertion = .subtract
        performingMath = true
        previousNumber = numberOnScreen
    }
    @IBAction func multiply(_ sender: UIButton) {
        lable.text = "x"
        opertion = .multiply
        performingMath = true
        previousNumber = numberOnScreen
    }
    @IBAction func divide(_ sender: UIButton) {
        lable.text = "/"
        opertion = .divide
        performingMath = true
        previousNumber = numberOnScreen
    }
    
    @IBAction func giveMeAnswer(_ sender: UIButton) {
        if performingMath == true{
            switch opertion{
            case .add:
                numberOnScreen = previousNumber + numberOnScreen
                makeOKNumberString(from: numberOnScreen)
            case .subtract:
                numberOnScreen = previousNumber - numberOnScreen
                makeOKNumberString(from: numberOnScreen)
            case .multiply:
                numberOnScreen = previousNumber * numberOnScreen
                makeOKNumberString(from: numberOnScreen)
            case .divide:
                numberOnScreen = previousNumber / numberOnScreen
                makeOKNumberString(from: numberOnScreen)
            case .none:
                lable.text = "0"
            }
            performingMath = false
            startNew = true
        }
    }
    
    @IBAction func numbers(_ sender: UIButton) {
        let inputNumber = sender.tag - 1
        if lable.text != nil{
            if startNew == true{
            lable.text = "\(inputNumber)"
            startNew = false
            }else{
                if lable.text == "0" || lable.text == "+" || lable.text == "-" || lable.text == "x" || lable.text == "/"{
                    lable.text = "\(inputNumber)"
            }else{
                lable.text = lable.text! + "\(inputNumber)"
                }
            }
            numberOnScreen = Double(lable.text!) ?? 0
        }
    }
    
    @IBAction func clear(_ sender: UIButton) {
        lable.text = "0"
        numberOnScreen = 0
        previousNumber  = 0
        performingMath = false
        opertion = .none
        startNew = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
