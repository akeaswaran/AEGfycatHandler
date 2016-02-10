AEGfycatHandler
===============
![Version Status](http://img.shields.io/cocoapods/v/AEGfycatHandler.png)       ![license MIT](http://img.shields.io/badge/license-MIT-orange.png)


An simple Objective-C wrapper for the [Gfycat API](http://gfycat.com/api).

###Installation
Just drag and drop the AEGfycatHandler folder into your Xcode project and import `AEGfycatViewerController.h` or `AEGfycatHandler.h` where needed. Alternatively, you can add `pod 'AEGfycatHandler'` to your Podfile and have CocoaPods import the files for you.

If you are supporting iOS 9.0+, you will also need to add the following to your Info.plist file in order for AEGfycatHandler to work correctly.

```
<key>NSAppTransportSecurity</key>
<dict>
   <key>NSAllowsArbitraryLoads</key>
   <false/>
   <key>NSExceptionDomains</key>
   <dict>
       <key>gfycat.com</key>
       <dict>
           <key>NSIncludesSubdomains</key>
           <true/>
           <key>NSTemporaryExceptionAllowsInsecureHTTPLoads</key>
           <true/>
           <key>NSTemporaryExceptionMinimumTLSVersion</key>
           <string>TLSv1.1</string>
       </dict>
   </dict>
</dict>
```

###Usage
It is recommended to use `AEGfycatViewerController` or a custom subclass of it to handle all of your Gfycat needs, but if you want to use another custom view controller to handle Gfycat viewing, you can import `AEGfycatHandler.h` and call the methods you need.

Refer to `AEGfycatViewerController.h` and `AEGfycatHandler.h` for more information on how to use AEGfycatHandler.

###License
See [License.md](https://github.com/akeaswaran/AEGfycatHandler/blob/master/License.md).
