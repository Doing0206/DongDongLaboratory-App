//
//  RateViewController.swift
//  DongDongLaboratory
//
//  Created by Doing on 2018/12/2.
//  Copyright © 2018年 Doing. All rights reserved.
//

import UIKit

struct USD{
    var currency:String?
    var rate:Double?
    var date:String?
}
struct RMB{
    var currency:String?
    var rate:Double?
}
struct AUD{
    var currency:String?
    var rate:Double?
}
struct THB{
    var currency:String?
    var rate:Double?
}
struct HKD{
    var currency:String?
    var rate:Double?
}
struct MYR{
    var currency:String?
    var rate:Double?
}
struct JPY{
    var currency:String?
    var rate:Double?
}

struct AllData:Decodable {
    var data:SingleData?
}
struct SingleData:Decodable {
    var USD:USDData?
    var RMB:RMBData?
    var AUD:AUDData?
    var THB:THBData?
    var HKD:HKDData?
    var MYR:MYRData?
    var JPY:JPYData?
}
struct USDData:Decodable {
    var currency:String?
    var rate:Double?
    var date:String?
}
struct RMBData:Decodable {
    var currency:String?
    var rate:Double?
}
struct AUDData:Decodable {
    var currency:String?
    var rate:Double?
}
struct THBData:Decodable {
    var currency:String?
    var rate:Double?
}
struct HKDData:Decodable {
    var currency:String?
    var rate:Double?
}
struct MYRData:Decodable {
    var currency:String?
    var rate:Double?
}
struct JPYData:Decodable {
    var currency:String?
    var rate:Double?
}


class RateViewController: UIViewController {

    @IBAction func backToCalculator(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    @IBOutlet weak var AnswerLable: UILabel!
    
    @IBOutlet weak var USDLable: UILabel!
    @IBOutlet weak var RMBLable: UILabel!
    @IBOutlet weak var AUDLable: UILabel!
    @IBOutlet weak var THBLable: UILabel!
    @IBOutlet weak var HKDLable: UILabel!
    @IBOutlet weak var MYRLable: UILabel!
    @IBOutlet weak var JPYLable: UILabel!
    @IBOutlet weak var dateLable: UILabel!
    
    var infoFromViewOne:Double?
    let apiAddress = "https://api.opencube.tw/currency/exchange?from=TWD"
    var urlSession = URLSession(configuration: .default)
    var isDownloading = false

    override func viewDidLoad() {
        super.viewDidLoad()
        AnswerLable.text = "\(infoFromViewOne)"
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
                        let okData = try JSONDecoder().decode(AllData.self, from: loadedData)
                        let usdC = okData.data?.USD?.currency
                        let usdR = okData.data?.USD?.rate
                        let usdD = okData.data?.USD?.date
                        let rmbC = okData.data?.RMB?.currency
                        let rmbR = okData.data?.RMB?.rate
                        let audc = okData.data?.AUD?.currency
                        let audR = okData.data?.AUD?.rate
                        let thbC = okData.data?.THB?.currency
                        let thbR = okData.data?.THB?.rate
                        let hkdC = okData.data?.HKD?.currency
                        let hkdR = okData.data?.HKD?.rate
                        let myrC = okData.data?.MYR?.currency
                        let myrR = okData.data?.MYR?.rate
                        let jpyC = okData.data?.JPY?.currency
                        let jpyR = okData.data?.JPY?.rate
                        
                        let usd = USD.init(currency: usdC, rate: usdR, date: usdD)
                        let rmb = RMB.init(currency: rmbC, rate: rmbR)
                        let aud = AUD.init(currency: audc, rate: audR)
                        let thb = THB.init(currency: thbC, rate: thbR)
                        let hkd = HKD.init(currency: hkdC, rate: hkdR)
                        let myr = MYR.init(currency: myrC, rate: myrR)
                        let jpy = JPY.init(currency: jpyC, rate: jpyR)
                        
                        DispatchQueue.main.async {
                            self.USDsettingInfo(usd: usd)
                            self.RMBsettingInfo(rmb: rmb)
                            self.AUDsettingInfo(aud: aud)
                            self.THBsettingInfo(thb: thb)
                            self.HKDsettingInfo(hkd: hkd)
                            self.MYRsettingInfo(myr: myr)
                            self.JPYsettingInfo(jpy: jpy)
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
    
    func USDsettingInfo(usd:USD){
        USDLable.text = usd.currency! + "\n" + "\(usd.rate!)"
        dateLable.text = usd.date!
        self.isDownloading = false
    }
    func RMBsettingInfo(rmb:RMB){
        RMBLable.text = rmb.currency! + "\n" + "\(rmb.rate!)"
        self.isDownloading = false
    }
    func AUDsettingInfo(aud:AUD){
        AUDLable.text = aud.currency! + "\n" + "\(aud.rate!)"
        self.isDownloading = false
    }
    func THBsettingInfo(thb:THB){
        THBLable.text = thb.currency! + "\n" + "\(thb.rate!)"
        self.isDownloading = false
    }
    func HKDsettingInfo(hkd:HKD){
        HKDLable.text = hkd.currency! + "\n" + "\(hkd.rate!)"
        self.isDownloading = false
    }
    func MYRsettingInfo(myr:MYR){
        MYRLable.text = myr.currency! + "\n" + "\(myr.rate!)"
        self.isDownloading = false
    }
    func JPYsettingInfo(jpy:JPY){
        JPYLable.text = jpy.currency! + "\n" + "\(jpy.rate!)"
        self.isDownloading = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
