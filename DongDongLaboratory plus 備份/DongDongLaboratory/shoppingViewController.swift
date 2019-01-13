//
//  shoppingViewController.swift
//  DongDongLaboratory
//
//  Created by Doing on 2018/11/22.
//  Copyright © 2018年 Doing. All rights reserved.
//

import UIKit

class shoppingViewController: UIViewController {
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    @IBAction func backToMenu(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
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
