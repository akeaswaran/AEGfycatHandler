//
//  AEGfycatViewerController.h
//  AEGfycatHandler
//
//  Created by Akshay Easwaran on 6/27/14.
//  Copyright (c) 2014 Akshay Easwaran. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AEGfycatViewerController : UIViewController

/**
 The background color for the Gfy viewer.
 */
@property (strong, nonatomic) UIColor *viewerBackgroundColor;

/**
 Initializes the viewer with an NSURL to a gif or a Gfy. The URL can be to either format; the viewer will check the URL then proceed with the appropriate action.
 
 @param url The URL of the gif to be uploaded and converted into Gfy format.
 */
-(instancetype)initWithGfyURL:(NSURL*)url;
@end
