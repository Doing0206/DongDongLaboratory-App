//
//  Taobao2ViewController.swift
//  DongDongLaboratory
//
//  Created by Doing on 2018/11/22.
//  Copyright © 2018年 Doing. All rights reserved.
//

import UIKit
import WebKit
class Taobao2ViewController: UIViewController,WKNavigationDelegate {
    @IBOutlet weak var Taobao2ActivityIndicator: UIActivityIndicatorView!
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    @IBOutlet weak var Taobao2WebView: WKWebView!
    @IBAction func backToShopping(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        Taobao2WebView.navigationDelegate = self
        if let url = URL(string: "https://world.taobao.com/"){
            let request = URLRequest(url: url)
            Taobao2WebView.load(request)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        Taobao2ActivityIndicator.startAnimating() 
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        Taobao2ActivityIndicator.stopAnimating()
    }
}
