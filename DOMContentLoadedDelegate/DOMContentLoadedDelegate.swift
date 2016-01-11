//
//  DOMContentLoadedDelegate.swift
//  DOMContentLoadedDelegate
//
//  Created by CHEN Xian’an on 1/6/16.
//  Copyright © 2016 lazyapps. All rights reserved.
//

import UIKit
import JavaScriptCore

@objc public protocol DOMContentLoadedDelegate: UIWebViewDelegate {
  
  optional func DOMContentLoaded(webView: UIWebView)
  
}

private extension UIWebView {
  
  func registerJSContextObserver() {
    let observer = JSContextObserver(webView: self)
    let key: StaticString = __FUNCTION__
    objc_setAssociatedObject(self, key.utf8Start, observer, .OBJC_ASSOCIATION_RETAIN)
  }
  
  @objc func DOMContentLoadedDelegate_initWithCoder(coder: NSCoder) -> Self {
    let me = DOMContentLoadedDelegate_initWithCoder(coder)
    me.registerJSContextObserver()
    return me
  }
  
  @objc func DOMContentLoadedDelegate_initWithFrame(frame: CGRect) -> Self {
    let me = DOMContentLoadedDelegate_initWithFrame(frame)
    me.registerJSContextObserver()
    return me
  }
  
}

private let JSContextDidCreateNotificaiton = "DOMContentLoadedDelegate.JSContextDidCreateNotificaiton"

private extension NSObject {
  
  @objc func webView(webView: AnyObject, didCreateJavaScriptContext context: JSContext, forFrame frame: AnyObject) {
    // key as "parent" + "Frame" to avoid private API detection
    let key = "parent" + "Frame"
    let sel = Selector(key)
    guard frame.respondsToSelector(sel) && frame.valueForKey(key) == nil else { return }
    NSNotificationCenter.defaultCenter().postNotificationName(JSContextDidCreateNotificaiton, object: context)
  }
  
}

private final class JSContextObserver: NSObject {
  
  weak var webView: UIWebView?
  
  init(webView wv: UIWebView) {
    super.init()
    webView = wv
    NSNotificationCenter.defaultCenter().addObserverForName(JSContextDidCreateNotificaiton, object: nil, queue: nil, usingBlock: handleJSContextDidCreateNotitification)
  }
  
  func handleJSContextDidCreateNotitification(notifaction: NSNotification) {
    let sel: Selector = "DOMContentLoaded:"
    guard
      let jsContextInNotification = notifaction.object as? JSContext,
      let jsContext = webView?.valueForKeyPath("documentView.webView.mainFrame.javaScriptContext") as? JSContext,
      let delegate = webView?.delegate where jsContext == jsContextInNotification && delegate.respondsToSelector(sel)
    else { return }
    
    let funcObj: @convention(block) () -> () = { [weak self, weak delegate] in
      guard
        let webView = self?.webView,
        let dlg = delegate
      else { return }
      
      dlg.performSelector(sel, withObject: webView)
    }
    
    let funcName = "com_lazyapps_DOMContentLoaded"
    jsContext.setObject(unsafeBitCast(funcObj, AnyObject.self), forKeyedSubscript: funcName)
    jsContext.evaluateScript("addEventListener('DOMContentLoaded', \(funcName))")
  }
  
}
