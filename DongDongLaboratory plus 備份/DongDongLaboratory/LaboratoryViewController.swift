//
//  LaboratoryViewController.swift
//  DongDongLaboratory
//
//  Created by Doing on 2018/11/21.
//  Copyright © 2018年 Doing. All rights reserved.
//

import UIKit
import WebKit
class LaboratoryViewController: UIViewController,WKNavigationDelegate {
    @IBOutlet weak var myActivityIndicator: UIActivityIndicatorView!
    @IBAction func backToManu(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var myWebView: WKWebView!
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        myWebView.navigationDelegate = self
        if let url = URL(string: "https://www.facebook.com/DigimonDigivice/"){
           let request = URLRequest(url: url)
            myWebView.load(request)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        myActivityIndicator.startAnimating()
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        myActivityIndicator.stopAnimating()
    }
}
