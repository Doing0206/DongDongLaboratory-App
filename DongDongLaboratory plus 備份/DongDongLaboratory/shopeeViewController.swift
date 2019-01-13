//
//  shopeeViewController.swift
//  DongDongLaboratory
//
//  Created by Doing on 2018/11/22.
//  Copyright © 2018年 Doing. All rights reserved.
//

import UIKit
import WebKit
class shopeeViewController: UIViewController,WKNavigationDelegate {
    @IBOutlet weak var shopeeActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var shopeeWebView: WKWebView!
    @IBAction func backToShopping(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        shopeeWebView.navigationDelegate = self
        if let url = URL(string: "https://shopee.tw/search?keyword=%E6%80%AA%E7%8D%B8%E5%B0%8D%E6%89%93%E6%A9%9F"){
            let request = URLRequest(url: url)
            shopeeWebView.load(request)
    }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        shopeeActivityIndicator.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        shopeeActivityIndicator.stopAnimating()
    }
}
