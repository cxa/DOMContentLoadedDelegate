//
//  ViewController.swift
//  Demo
//
//  Created by CHEN Xian’an on 1/7/16.
//  Copyright © 2016 lazyapps. All rights reserved.
//

import UIKit
import DOMContentLoadedDelegate

class ViewController: UIViewController {

  lazy private var webView: UIWebView = {
    let w = UIWebView(frame: CGRectZero)
    w.translatesAutoresizingMaskIntoConstraints = false
    w.delegate = self
    return w
  }()
  
  override func loadView() {
    super.loadView()
    view.addSubview(webView)
    NSLayoutConstraint.activateConstraints([
      webView.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor),
      webView.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor),
      webView.topAnchor.constraintEqualToAnchor(view.topAnchor),
      webView.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor)
    ])
    
    guard let url = NSURL(string: "https://en.wikipedia.org/wiki/Special:Random") else { fatalError("Fail to construct URL") }
    webView.loadRequest(NSURLRequest(URL: url))
  }

  override func prefersStatusBarHidden() -> Bool {
    return true
  }
  
}


extension ViewController: DOMContentLoadedDelegate {
  
  func webViewDidFinishLoad(webView: UIWebView) {
    print("webViewDidFinishLoad: ", NSDate())
  }
  
  func DOMContentLoaded(webView: UIWebView) {
    print("DOM accessible, e.g. you can get document title now: ", webView.stringByEvaluatingJavaScriptFromString("document.title"), " ", NSDate())
  }
  
}
