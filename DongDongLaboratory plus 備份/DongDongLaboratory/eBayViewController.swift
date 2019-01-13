//
//  eBayViewController.swift
//  DongDongLaboratory
//
//  Created by Doing on 2018/11/22.
//  Copyright © 2018年 Doing. All rights reserved.
//

import UIKit
import WebKit
class eBayViewController: UIViewController,WKNavigationDelegate {
    @IBOutlet weak var eBayActivityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var eBayWebView: WKWebView!
    @IBAction func backToShopping(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        eBayWebView.navigationDelegate = self
        if let url = URL(string: "https://www.ebay.com/sch/i.html?_from=R40&_trksid=p2380057.m570.l1313.TR9.TRC1.A0.H0.Xdigivice.TRS2&_nkw=digivice&_sacat=0"){
            let request = URLRequest(url: url)
            eBayWebView.load(request)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        eBayActivityIndicator.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
       eBayActivityIndicator.stopAnimating()
    }
}
