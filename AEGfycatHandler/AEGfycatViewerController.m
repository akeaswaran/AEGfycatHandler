//
//  AEGfycatViewerController.m
//  AEGfycatHandler
//
//  Created by Akshay Easwaran on 6/27/14.
//  Copyright (c) 2014 Akshay Easwaran. All rights reserved.
//

#import "AEGfycatViewerController.h"
#import "AEGfycatHandler.h"

#define kAEErrorMessage @"Error"

#define AELog(...) ((void)0) // NSLog(__VA_ARGS__)

@interface AEGfycatViewerController () <UIWebViewDelegate>
{
    NSURL *_gfyURL;
    UIWebView *webView;
}
@end

@implementation AEGfycatViewerController

-(instancetype)initWithGfyURL:(NSURL*)url {
    self = [super init];
    if (self) {
        _gfyURL = url;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (!_viewerBackgroundColor) {
        _viewerBackgroundColor = [UIColor blackColor];
    }
    
    webView = [[UIWebView alloc] initWithFrame:self.view.frame];
    [webView setDelegate:self];
    [webView setScalesPageToFit:YES];
    [webView setAllowsInlineMediaPlayback:YES];
    [webView setMediaPlaybackRequiresUserAction:NO];
    [webView setMediaPlaybackAllowsAirPlay:YES];
    [webView setBackgroundColor:_viewerBackgroundColor];
    [self.view addSubview:webView];
    [self.view setBackgroundColor:_viewerBackgroundColor];
    
    if ([AEGfycatHandler isGfycatLink:_gfyURL]) {
        self.title = [NSString stringWithFormat:@"Looking up Gfycat link..."];
        [AEGfycatHandler getExistingGfycatLink:_gfyURL completion:^(NSURL *gfycatURL, NSError *error) {
            if (!error) {
                AELog(@"Looked up given Gfy URL %@ and found Gfy at %@",_gfyURL.absoluteString,gfycatURL.absoluteString);
                [webView loadRequest:[NSURLRequest requestWithURL:gfycatURL]];
                self.title = gfycatURL.absoluteString;
            } else {
                AELog(@"AEGfycatViewerController failed to lookup Gfy at %@ with error: %@",_gfyURL.absoluteString, error.localizedDescription);
            }
        }];
    } else {
        self.title = [NSString stringWithFormat:@"Converting GIF to Gfycat..."];
        [AEGfycatHandler convertGIFToGfycat:_gfyURL completion:^(NSURL *gfycatURL, NSError *error) {
            if (!error) {
                AELog(@"Converted GIF at %@ to Gfy URL: %@",_gfyURL.absoluteString,gfycatURL.absoluteString);
                [webView loadRequest:[NSURLRequest requestWithURL:gfycatURL]];
                self.title = gfycatURL.absoluteString;
            } else {
                AELog(@"AEGfycatViewerController failed to convert GIF at %@ to Gfy with error: %@",_gfyURL.absoluteString, error.localizedDescription);
            }
        }];
    }
    
}

#pragma mark - UIWebViewDelegate methods

-(void)webViewDidStartLoad:(UIWebView *)webView {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    //Ignore this error since it has no bearing on the loading of the HTML5 video
    if (![error.localizedDescription isEqualToString:@"Plug-in handled load"]) {
        self.title = @"Error";
        AELog(@"[AEGfycatViewerController webView] didFailLoadWithError: %@ ",error.localizedDescription);
        
    }
}


@end
