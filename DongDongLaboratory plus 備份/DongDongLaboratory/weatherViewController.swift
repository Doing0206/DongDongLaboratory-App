//
//  weatherViewController.swift
//  DongDongLaboratory
//
//  Created by Doing on 2018/11/28.
//  Copyright © 2018年 Doing. All rights reserved.
//

import UIKit
import WebKit

class weatherViewController: UIViewController,WKNavigationDelegate {
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    @IBAction func backToPickup(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    @IBOutlet weak var weatherActivityIndicator: UIActivityIndicatorView!
    var linkFromViewOne:String?
    @IBOutlet weak var myWebView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        myWebView.navigationDelegate = self
        if let okLink = linkFromViewOne, let okURL = URL(string: okLink){
            let request = URLRequest(url: okURL)
            myWebView.load(request)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        weatherActivityIndicator.startAnimating()
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        weatherActivityIndicator.stopAnimating()
    }
}
