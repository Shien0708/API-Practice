//
//  MusicWebViewController.swift
//  API Practice
//
//  Created by Shien on 2022/5/27.
//

import UIKit
import WebKit

class MusicWebViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    
    var url: URL
    
    init?(coder:NSCoder, url: URL) {
        self.url = url
        super.init(coder: coder)
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.load(URLRequest(url: url))
        // Do any additional setup after loading the view.
    }

    
    // MARK: - Navigation


}
