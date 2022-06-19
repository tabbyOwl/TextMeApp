//
//  ViewController.swift
//  TextMeApp
//
//  Created by jane on 06.05.2022.
//

import UIKit
import WebKit

final class AuthorizationViewController: UIViewController {
    
    //MARK: - @IBOutlets
    
	@IBOutlet weak var webView: WKWebView! {
		didSet {
			webView.navigationDelegate = self
		}
	}
    
    //MARK: - Private properties

	private var session = Session.instance

	//MARK: - Override methods

	override func viewDidLoad() {
		super.viewDidLoad()
		authorize()
	}

	//MARK: - Private methods

	private func authorize()  {
		var urlComponents = URLComponents(string: "https://oauth.vk.com/authorize")
		urlComponents?.queryItems = [
            URLQueryItem(name: "client_id", value: "8197761"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "335878"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.68") ]

        guard let url = urlComponents?.url else {return}
        let request = URLRequest(url: url)
        webView.load(request)
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

        decisionHandler(.cancel)
		performSegue(withIdentifier: "login", sender: nil)
    }
}
