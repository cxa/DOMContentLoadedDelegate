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

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

+ (void)load
{
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    // Swizzle `initWithCoder:` & `initWithFrame:` to registerJ SContextObserver automatically
    SEL selector = @selector(initWithCoder:);
    Method method = class_getInstanceMethod(self, selector);
    id (*origInitWithCoder)(id, SEL, id) = (void *)class_getMethodImplementation(self, selector);
    IMP newInitWithCoder = imp_implementationWithBlock(^id(id sender, id coder) {
      id ret = origInitWithCoder(sender, selector, coder);
      [ret performSelector:NSSelectorFromString(@"registerJSContextObserver")];
      return ret;
    });
    
    if (!class_addMethod(self, selector, newInitWithCoder, method_getTypeEncoding(method)))
      method_setImplementation(method, newInitWithCoder);
    
    selector = @selector(initWithFrame:);
    method = class_getInstanceMethod(self, selector);
    id (*origInitWithFrame)(id, SEL, CGRect) = (void *)class_getMethodImplementation(self, selector);
    IMP newInitWithFrame = imp_implementationWithBlock(^id(id sender, CGRect frame) {
      id ret = origInitWithFrame(sender, selector, frame);
      [ret performSelector:NSSelectorFromString(@"registerJSContextObserver")];
      return ret;
    });
    
    if (!class_addMethod(self, selector, newInitWithFrame, method_getTypeEncoding(method)))
      method_setImplementation(method, newInitWithFrame);
  });
}

#pragma clang diagnostic pop

@end
