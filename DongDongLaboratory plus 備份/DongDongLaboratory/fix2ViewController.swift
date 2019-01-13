//
//  fix2ViewController.swift
//  DongDongLaboratory
//
//  Created by Doing on 2018/11/23.
//  Copyright © 2018年 Doing. All rights reserved.
//

import UIKit

class fix2ViewController: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var Date: UILabel!
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    var infoFromViewFix1:Int?
    
    @IBOutlet weak var fixTextInput: UITextField!
    @IBOutlet weak var myButton: UIButton!
    @IBAction func TextFieldDidChange(_ sender: UITextField) {
        if sender.text != ""{
            myButton.setTitle("確認", for: .normal)
        }else{
            myButton.setTitle("返回", for: .normal)
        }
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        if let text = fixTextInput.text{
            guard let Fix1ViewController = tabBarController?.viewControllers?[0] as? fix1ViewController else{ return }
            
            if text != ""{
                if infoFromViewFix1 != nil{
                    Fix1ViewController.toDos[infoFromViewFix1!] = text
                    infoFromViewFix1 = nil
                }else{
                    Fix1ViewController.toDos.append(text)
                }
                Fix1ViewController.fixTableView.reloadData()
                UserDefaults.standard.set(Fix1ViewController.toDos, forKey: "todos")
            }else{
                if infoFromViewFix1 != nil{
                    Fix1ViewController.toDos.remove(at: infoFromViewFix1!)
                    Fix1ViewController.fixTableView.reloadData()
                    UserDefaults.standard.set(Fix1ViewController.toDos, forKey: "todos")
                    infoFromViewFix1 = nil
                }
             }
        }
        fixTextInput.text = ""
        myButton.setTitle("返回", for: .normal)
        tabBarController?.selectedIndex = 0
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        fixTextInput.becomeFirstResponder()
        fixTextInput.delegate = self
        let now = NSDate()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        
        let nowDate = formatter.string(from: now as Date)
        Date.text = nowDate

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if infoFromViewFix1 != nil{
            if let Fix1ViewController = tabBarController?.viewControllers?[0] as? fix1ViewController{
                fixTextInput.text = Fix1ViewController.toDos[infoFromViewFix1!]
                myButton.setTitle("確認", for: .normal)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        buttonPressed(UIButton())
        return true
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
