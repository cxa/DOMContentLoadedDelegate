# `DOMContentLoadedDelegate`

Need to evaluate JS on `UIWebView` safely? Wait until `- webViewDidFinishLoad:`. But it is too slow if there are many resources (e.g. images) to load. `DOMContentLoadedDelegate` lets you access DOM as soon as possible.

## How to Use

1. Add the `DOMContentLoadedDelegate` repository as a submodule of your application’s repository.
2. Drag and drop `DOMContentLoadedDelegate.xcodeproj` into your application’s Xcode project or workspace.
3. On the “General” tab of your application target’s settings, add `DOMContentLoadedDelegate.framework` to the “Embedded Binaries” section.

Set your class confirms to `DOMContentLoadedDelegate` and do things that required to access DOM in `- DOMContentLoaded:`.

Or, If you would prefer to use Carthage or CocoaPods, please pull request.

## About Me

* Twitter: [@_cxa](https://twitter.com/_cxa)
* Apps available in App Store: <http://lazyapps.com>
* PayPal: xianan.chen+paypal 📧 gmail.com, buy me a cup of coffee if you find it's useful for you.

## License

`DOMContentLoadedDelegate` is released under the MIT license. In short, it's royalty-free but you must keep the copyright notice in your code or software distribution.
