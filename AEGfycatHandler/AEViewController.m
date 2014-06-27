//
//  AEViewController.m
//  AEGfycatHandler
//
//  Created by Akshay Easwaran on 6/27/14.
//  Copyright (c) 2014 Akshay Easwaran. All rights reserved.
//

#import "AEViewController.h"
#import "AEGfycatViewerController.h"

@interface AEViewController ()

@end

@implementation AEViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.title = @"AEGfycatHandler example";
}

-(IBAction)convertGIF:(id)sender {
    [self.navigationController pushViewController:[[AEGfycatViewerController alloc] initWithGfyURL:[NSURL URLWithString:@"http://i.imgur.com/CG2EfIX.gif"]] animated:YES];
}

-(IBAction)lookUpGfy:(id)sender {
    [self.navigationController pushViewController:[[AEGfycatViewerController alloc] initWithGfyURL:[NSURL URLWithString:@"http://gfycat.com/ScaryGrizzledComet"]] animated:YES];
}


@end
