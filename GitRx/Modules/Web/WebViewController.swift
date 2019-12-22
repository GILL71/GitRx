//
//  WebViewController.swift
//  GitRx
//
//  Created by Михаил Нечаев on 23.12.2019.
//  Copyright © 2019 Михаил Нечаев. All rights reserved.
//

import UIKit
import WebKit

final class WebViewController: UIViewController, WKUIDelegate {
    
    // MARK: - Private properties
    
    private let url: URL
    private lazy var webView: WKWebView = {
        let webView = WKWebView(frame: view.frame)
        return webView
    }()
    
    // MARK: - Initializers
    
    init(url: URL) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle methods
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let myRequest = URLRequest(url: url)
        webView.load(myRequest)
    }

}
