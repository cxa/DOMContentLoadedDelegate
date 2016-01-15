//
//  DOMContentLoadedDelegateTests.swift
//  DOMContentLoadedDelegateTests
//
//  Created by CHEN Xian’an on 1/6/16.
//  Copyright © 2016 lazyapps. All rights reserved.
//

import XCTest
@testable import DOMContentLoadedDelegate

class DOMContentLoadedDelegateTests: XCTestCase, DOMContentLoadedDelegate {
  
  var DOMContentLoaded = false
  
  var DOMContentLoadedExp: XCTestExpectation?
  
  func testDOMContentLoaded() {
    let webView = UIWebView(frame: CGRectZero)
    webView.delegate = self
    webView.loadRequest(NSURLRequest(URL: NSURL(string: "https://en.wikipedia.org/wiki/Special:Random")!))
    DOMContentLoadedExp = expectationWithDescription(__FUNCTION__)
    waitForExpectationsWithTimeout(15) { error in
      print(error)
      XCTAssertTrue(self.DOMContentLoaded)
    }
  }
  
  func DOMContentLoaded(webView: UIWebView) {
    DOMContentLoaded = true
    DOMContentLoadedExp?.fulfill()
  }
  
}