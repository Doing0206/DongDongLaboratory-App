//
//  WellcomeBackViewController.swift
//  DongDongLaboratory
//
//  Created by Doing on 2018/11/21.
//  Copyright © 2018年 Doing. All rights reserved.
//

import UIKit

struct Temp{
    var elementValue:String?
}
struct RECORDS:Decodable{
    var records:LOCATION?
}
struct LOCATION:Decodable{
   var location:[WEATHERElEMENT]?
}
struct WEATHERElEMENT:Decodable{
    var weatherElement:[ELEMENTVALUE]?
}
struct ELEMENTVALUE:Decodable{
    var elementValue:String?
}

class WellcomeBackViewController: UIViewController {

    @IBOutlet weak var tempLable: UILabel!
    @IBOutlet weak var date: UILabel!
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    @IBOutlet weak var Dong: UIImageView!
    @IBAction func goToMainManu(_ sender: UIButton) {
        let MainMenu = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainMenu")
        present(MainMenu, animated: true, completion: nil)
    }
    let apiAddress = "https://opendata.cwb.gov.tw/api/v1/rest/datastore/O-A0003-001?Authorization=CWB-2B16EBBC-2995-400B-B3FE-5A7CC9A2A470&elementName=TEMP"
    var urlSession = URLSession(configuration: .default)
    var isDownloading = false
    override func viewDidLoad() {
        super.viewDidLoad()
        //DongDong
        Dong.layer.cornerRadius = Dong.frame.size.width / 2
        Dong.clipsToBounds = true
        
        //Date
        let now = NSDate()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        let nowDate = formatter.string(from: now as Date)
        date.text = nowDate
        
        //Temp
        downloadInfo(withAddress: apiAddress)
    }
    func downloadInfo(withAddress webAddress:String){
        if let url = URL(string: webAddress){
            let task = urlSession.dataTask(with: url, completionHandler: {
                (data, response, error) in
                if error != nil{
                    let errorCode = (error! as NSError).code
                    if errorCode == -1009{
                        DispatchQueue.main.async {
                            self.popAlert(withTitle: "No Internet Connection")
                        }
                    }else{
                        DispatchQueue.main.async {
                            self.popAlert(withTitle: "Sorry")
                        }
                    }
                    self.isDownloading = false
                    return
                }
                if let loadedData = data{
                    do{
                        let okData = try JSONDecoder().decode(RECORDS.self, from: loadedData)
                        let okTEMP = okData.records?.location?[2].weatherElement?[0].elementValue
                        let temp = Temp.init(elementValue: okTEMP)
                        
                        DispatchQueue.main.async {
                            self.tempsettingInfo(temp: temp)

                        }
                    }catch{
                        DispatchQueue.main.async {
                            self.popAlert(withTitle: "Sorry")
                        }
                        self.isDownloading = false
                    }
                    
                }else{
                    self.isDownloading = false
                }
            })
            task.resume()
            isDownloading = true
        }
    }
    
    func popAlert(withTitle title:String){
        let alert = UIAlertController(title: title, message: "Please try again later", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    func tempsettingInfo(temp:Temp){
       tempLable.text = temp.elementValue!
        self.isDownloading = false
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
