//
//  KaideeViewController.swift
//  DongDongLaboratory
//
//  Created by Doing on 2018/11/22.
//  Copyright © 2018年 Doing. All rights reserved.
//

import UIKit
import WebKit
class KaideeViewController: UIViewController,WKNavigationDelegate {
    @IBOutlet weak var KaideeActivityIndicator: UIActivityIndicatorView!
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    @IBAction func backToShopping(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var KaideeWebView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        KaideeWebView.navigationDelegate = self
        if let url = URL(string: "https://www.kaidee.com/browse?q=digivice"){
            let request = URLRequest(url: url)
            KaideeWebView.load(request)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        KaideeActivityIndicator.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        KaideeActivityIndicator.stopAnimating()
    }
}
