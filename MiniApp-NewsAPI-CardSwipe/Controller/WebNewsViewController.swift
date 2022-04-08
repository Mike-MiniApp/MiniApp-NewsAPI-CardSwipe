//
//  WebNewsViewController.swift
//  MiniApp-NewsAPI-CardSwipe
//
//  Created by 近藤米功 on 2022/04/08.
//

import UIKit
import WebKit
class WebNewsViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    var catchSwipeNewsData: NewsArticles = NewsArticles(title: "", publishedAt: "", url: "", urlToImage: "", description: "")
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let newsUrl = URL(string: catchSwipeNewsData.url) else{
            return
        }
        let request = URLRequest(url: newsUrl)
        webView.load(request)
    }

}
