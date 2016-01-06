//
//  UIWebView+DOMContentLoadedDelegate.m
//  DOMContentLoadedDelegate
//
//  Created by CHEN Xian’an on 1/6/16.
//  Copyright © 2016 lazyapps. All rights reserved.
//

@import UIKit;
@import ObjectiveC.runtime;

@implementation UIWebView (DOMContentLoadedDelegate)

+ (void)load
{
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    Method m1 = class_getInstanceMethod(self, @selector(initWithCoder:));
    Method m2 = class_getInstanceMethod(self, NSSelectorFromString(@"DOMContentLoadedDelegate_initWithCoder:"));
    method_exchangeImplementations(m1, m2);
    m1 = class_getInstanceMethod(self, @selector(initWithFrame:));
    m2 = class_getInstanceMethod(self, NSSelectorFromString(@"DOMContentLoadedDelegate_initWithFrame:"));
    method_exchangeImplementations(m1, m2);
  });
}

@end
