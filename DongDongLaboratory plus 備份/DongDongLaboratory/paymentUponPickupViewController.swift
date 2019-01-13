//
//  paymentUponPickupViewController.swift
//  DongDongLaboratory
//
//  Created by Doing on 2018/11/27.
//  Copyright © 2018年 Doing. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
struct NewItem{
    var title:String?
    var link:String?
}

class paymentUponPickupViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate {
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    @IBAction func backToMenu(_ sender: UIButton) {
     dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var map: MKMapView!
    var locationManager:CLLocationManager?
    @IBAction func addMeAnnotation(_ sender: UILongPressGestureRecognizer) {
        let touchPoint = sender.location(in: map)
        let touchCoordinate: CLLocationCoordinate2D = map.convert(touchPoint, toCoordinateFrom: map)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = touchCoordinate
        annotation.title = "面交點"
        annotation.subtitle = "請準時赴約"
        map.addAnnotation(annotation)
    }
    
    var objects = [NewItem]()
    let xmlAddress = "https://www.cwb.gov.tw/rss/forecast/36_04.xml"
    var session = URLSession(configuration: .default)
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.delegate = self
        myTableView.dataSource = self
        downloadXML(withXMLAddress: xmlAddress)
        
        //map
        locationManager = CLLocationManager()
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.activityType = .automotiveNavigation
        locationManager?.startUpdatingLocation()
        
        if let coordinate = locationManager?.location?.coordinate{
        let xScale:CLLocationDegrees = 0.018
        let yScale:CLLocationDegrees = 0.018
        let span:MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: yScale, longitudeDelta: xScale)
        let region:MKCoordinateRegion = MKCoordinateRegion(center: coordinate, span: span)
        map.setRegion(region, animated: true)
        }
    map.userTrackingMode = .followWithHeading
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("------------")
        print(locations[0].coordinate.latitude)
        print(locations[0].coordinate.longitude)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = objects[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showinfo"{
            if let dvc = segue.destination as? weatherViewController{
                if let selectedRow = myTableView.indexPathForSelectedRow?.row{
                    dvc.linkFromViewOne = objects[selectedRow].link
                }
            }
        }
    }
    func downloadXML(withXMLAddress xmlAddress:String){
        if let url = URL(string: xmlAddress){
            let task = session.dataTask(with: url, completionHandler: {
                (data, response, error) in
                if error != nil{
                    DispatchQueue.main.async {
                        self.popAlert(withTitle: "Sorry")
                    }
                    return
                }
                if let okData = data{
                    let parser = XMLParser(data: okData)
                    let rssParserDelegate = RSSParserDelegate()
                    parser.delegate = rssParserDelegate
                    if parser.parse() == true{
                        self.objects = rssParserDelegate.getResult()
                        DispatchQueue.main.async {
                            self.myTableView.reloadData()
                        }
                    }else{
                        print("parse fail")
                    }
                }
                
            })
            task.resume()
        }
    }
    
    func popAlert(withTitle title:String){
        let alert = UIAlertController(title: title, message: "Please try again later", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
}



