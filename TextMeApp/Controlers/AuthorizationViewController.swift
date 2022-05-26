//
//  ViewController.swift
//  TextMeApp
//
//  Created by jane on 06.05.2022.
//

import UIKit
import WebKit

class AuthorizationViewController: UIViewController {
    
    var session = Session.instance
   
    @IBOutlet weak var webview: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webview.navigationDelegate = self
        authorize()
    }
    
    func authorize()  {
    var urlComponents = URLComponents(string: "https://oauth.vk.com/authorize")
    urlComponents?.queryItems = [
        URLQueryItem(name: "client_id", value: "8173338"),
        URLQueryItem(name: "display", value: "mobile"),
        URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
        URLQueryItem(name: "scope", value: "335878"),
        URLQueryItem(name: "response_type", value: "token"),
        URLQueryItem(name: "v", value: "5.68") ]
    
        guard let url = urlComponents?.url else {return}
        let request = URLRequest(url: url)
        webview.load(request)
    }
}
    
    extension AuthorizationViewController: WKNavigationDelegate {
       
        func webView(_ webView: WKWebView,
                     decidePolicyFor navigationResponse: WKNavigationResponse,
                     decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
           
            guard let url = navigationResponse.response.url,
                url.path == "/blank.html",
                  let fragment = url.fragment else {
                   decisionHandler(.allow)
                      return
                  }
            
            let params = fragment
                .components(separatedBy: "&")
                .map { $0.components(separatedBy: "=")}
                .reduce([String: String](), { partialResult, param in
                    var dict = partialResult
                    let key = param[0]
                    let value = param[1]
                    dict[key] = value
                    return dict
                })
            
            guard let token = params["access_token"],
            let userID = params["user_id"] else {return}
            Session.instance.token = token
            Session.instance.userID = Int(userID)!
            performSegue(withIdentifier: "login", sender: nil)
            
            decisionHandler(.cancel)
                
        }
    }
