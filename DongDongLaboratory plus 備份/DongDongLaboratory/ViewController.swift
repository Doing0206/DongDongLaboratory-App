//
//  ViewController.swift
//  DongDongLaboratory
//
//  Created by Doing on 2018/11/20.
//  Copyright © 2018年 Doing. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var answer = 1
    var isOver = false
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var messageLable: UILabel!
    
    @IBOutlet weak var inputPassword: UITextField!
    
    @IBAction func loginButtom(_ sender: UIButton) {
        if isOver == false{
            //playing game
            print(answer)
            
            //take input text out
            let inputText = inputPassword.text!
            
            //clear textfield
            inputPassword.text = ""
            
            let inputNumber = Int(inputText)
            if inputNumber == nil{
                //wrong input
                messageLable.text = "無效輸入"
            }else{
                //input ok
                if inputNumber == Int(answer){
                    // Bingo! right answer
                    messageLable.text = ""
                    isOver = true
                    background.image = UIImage(named: "Finish")
                    let WellcomBack = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WellcomBack")
                    present(WellcomBack, animated: true, completion: nil)
                }else{
                    //wrong answer
                    messageLable.text = "不是東東老闆本人?"
                }
            }
        }else{
            //game is over
            messageLable.text = "請輸入密碼"
            answer = 1
            isOver = false
            background.image = UIImage(named: "BG")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inputPassword.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

