//
//  fix1ViewController.swift
//  DongDongLaboratory
//
//  Created by Doing on 2018/11/23.
//  Copyright © 2018年 Doing. All rights reserved.
//

import UIKit

class fix1ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    @IBOutlet weak var fixTableView: UITableView!
    @IBAction func backToMenu(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    var toDos = UserDefaults.standard.stringArray(forKey: "todos") ?? [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fixTableView.delegate = self
        fixTableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = toDos[indexPath.row]
        cell.textLabel?.textColor = .white
        cell.textLabel?.font = UIFont(name: "arial", size: 18)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            toDos.remove(at: indexPath.row)
            UserDefaults.standard.set(toDos, forKey: "todos")
            fixTableView.reloadData()
        }
    }
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        if let Fix2ViewController = tabBarController?.viewControllers?[1] as? fix2ViewController{
            Fix2ViewController.infoFromViewFix1 = indexPath.row
        }
        tabBarController?.selectedIndex = 1
    }
}


