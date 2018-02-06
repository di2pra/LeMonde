//
//  NewsViewController.swift
//  LeMonde
//
//  Created by Pradheep Rajendirane on 05/02/2018.
//  Copyright © 2018 Pradheep Rajendirane. All rights reserved.
//

import UIKit
import WebKit
import NVActivityIndicatorView

class NewsViewController: UIViewController {
    
    var newsUrl: String?
    var webView: WKWebView!
    
    @IBOutlet weak var loadingView: NVActivityIndicatorView!
    @IBOutlet weak var errorLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = Settings.mainColor
        
        self.initWebView()
        self.initLoadingView()
        self.initNavigationBar()
        
        if let url = newsUrl {
            self.errorLabel.isHidden = true
            let myURL = URL(string: url)
            let myRequest = URLRequest(url: myURL!)
            self.loadingView.startAnimating()
            webView.load(myRequest)
        } else {
            self.errorLabel.text = "Erreur pas d'article sélectionné"
        }
        
    }
    
    private func initLoadingView() {
        
        self.loadingView.color = .white
        self.loadingView.type = .lineScale
        
    }
    
    private func initWebView() {
        
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.navigationDelegate = self
        self.webView.isHidden = true
        
        // UI Init
        webView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(webView)
        
        self.view.addConstraints([
            NSLayoutConstraint(item: self.view, attribute: .top, relatedBy: .equal, toItem: self.webView, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: self.view, attribute: .bottom, relatedBy: .equal, toItem: self.webView, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: self.view, attribute: .left, relatedBy: .equal, toItem: self.webView, attribute: .left, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: self.view, attribute: .right, relatedBy: .equal, toItem: self.webView, attribute: .right, multiplier: 1, constant: 0),
            ])
        
        
    }
    
    private func initNavigationBar() {
        
        let title = UILabel()
        title.text = "\(Settings.mainTitle.uppercased()) - ARTICLE"
        title.font = UIFont(name: "Futura", size: 15)
        title.textColor = .white
        self.navigationItem.titleView = title
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension NewsViewController:WKNavigationDelegate {
    
    // Display the WebView when page loading is finished
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.webView.isHidden = false
        self.loadingView.stopAnimating()
    }
    
}
