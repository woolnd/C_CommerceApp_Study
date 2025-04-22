//
//  PaymentViewController.swift
//  Cproject
//
//  Created by wodnd on 4/21/25.
//

import UIKit
import WebKit

final class PaymentViewController: UIViewController {

    private var webView: WKWebView?
    private let getMessageScriptName: String = "receiveMessage"
    
    override func loadView() {
        let contentController = WKUserContentController()
        contentController.add(self, name: getMessageScriptName)
        
        let config = WKWebViewConfiguration()
        config.userContentController = contentController
        
        webView = WKWebView(frame: .zero, configuration: config)
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadWebView()
        setUserAgent()
        
        let button: UIButton = UIButton(frame: CGRect(x: 0, y: 400, width: 100, height: 100))
        button.setTitle("call", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.addAction(UIAction(handler: {
            [weak self] _ in
            self?.callJavaScript()
        }), for: .touchUpInside)
        
        view.addSubview(button)
    }
    
    private func loadWebView() {
        guard let htmlPath = Bundle.main.path(forResource: "test", ofType: "html") else { return }
        let url = URL(fileURLWithPath: htmlPath)
        var request = URLRequest(url: url)
        request.addValue("customValue", forHTTPHeaderField: "Header-Name")
        webView?.load(request)
    }
    
    private func setUserAgent() {
        webView?.customUserAgent = "Cproject/1.0.0/iOS"
    }
    
    private func setCookie() {
        guard let cookie = HTTPCookie(properties: [
            .domain: "google.co.kr",
            .path: "/",
            .name: "myCookie",
            .value: "value",
            .secure: "FALSE",
            .expires: NSDate(timeIntervalSinceNow: 3600)
        ]) else { return }
        
        webView?.configuration.websiteDataStore.httpCookieStore.setCookie(cookie)
    }
    
    private func callJavaScript() {
        webView?.evaluateJavaScript("javascriptFunction();")
    }
}

extension PaymentViewController: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        
        if message.name == getMessageScriptName {
            print("\(message.body)")
        }
    }
    
    
}

#Preview{
    PaymentViewController()
}
