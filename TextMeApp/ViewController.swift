//
//  ViewController.swift
//  TextMeApp
//
//  Created by jane on 06.05.2022.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    
    @IBOutlet weak var webview: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var urlComponents = URLComponents(string: "https://oauth.vk.com/autorize")
        //
       
        urlComponents?.queryItems = [
        URLQueryItem(name: "client_id", value: "1234567"),
        URLQueryItem(name: "display", value: "mobile"),
        URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
        URLQueryItem(name: "scope", value: "262150"),
        URLQueryItem(name: "response_type", value: "token"),
        URLQueryItem(name: "v", value: "5.68") ]
        //
        guard let url = urlComponents?.url else {return}
        let request = URLRequest(url: url)
        webview.load(request)
     
    }
    


}
