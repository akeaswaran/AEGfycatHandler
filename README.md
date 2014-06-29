AEGfycatHandler
===============
![Version Status](http://img.shields.io/cocoapods/v/AEGfycatHandler.png)       ![license MIT](http://img.shields.io/badge/license-MIT-orange.png)


An simple Objective-C wrapper for the [Gfycat API](http://gfycat.com/api). Built for use in my upcoming Reddit client, Crescent for iOS.

###Installation
Just drag and drop the AEGfycatHandler folder into your Xcode project and import `AEGfycatViewerController.h` or `AEGfycatHandler.h` where needed. A Cocoapod for this library will be created eventually.

###Usage
It is recommended to use `AEGfycatViewerController` or a custom subclass of it to handle all of your Gfycat needs, but if you want to use another custom view controller to handle Gfycat viewing, you can import `AEGfycatHandler.h` and call the methods you need. 

Both `AEGfycatViewerController` and `AEGfycatHandler` have well-commented header files that explain how to use each method and what each method returns, as well as in-line comments where necessary to explain certain decisions.

###License
See [License.md](https://github.com/akeaswaran/AEGfycatHandler/blob/master/License.md).


