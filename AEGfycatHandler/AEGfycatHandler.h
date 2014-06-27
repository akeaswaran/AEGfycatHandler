//
//  AEGfycatHandler.h
//  AEGfycatHandler
//
//  Created by Akshay Easwaran on 6/27/14.
//  Copyright (c) 2014 Akshay Easwaran. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^AEGfycatCompletionBlock)(NSURL* gfycatURL, NSError *error);
typedef void (^AEGfycatExistsCompletionBlock)(BOOL exists, NSError *error);

@interface AEGfycatHandler : NSObject
/**
 Converts the GIF at the given NSURL to a gfy (i.e. Gfycat format) and returns the link to the Gfycat HTML5 video, along with an NSError (just in case). 
 
 @note The URL should preferably end in .gif, like in this example: [NSURL URLWithString:@"http://i.imgur.com/CG2EfIX.gif"].
 
 @param gifURL The URL of the gif to be uploaded and converted into Gfy format.
 @param completion A completion block that runs on the main queue, returning an NSURL object to the Gfycat HTML5 link and an NSError object.
 */
+ (void)convertGIFToGfycat:(NSURL*)gifURL completion:(AEGfycatCompletionBlock)completion;

/**
 Looks up the NSURL provided for a gfy (Gfycat-formatted GIF) on Gfycat and returns a link to the Gfycat HTML5 video, along with an NSError (just in case). 
 
 @note The URL MUST be in Gfycat's format, like in this example: [NSURL URLWithString:@"http://gfycat.com/ScaryGrizzledComet"].
 
 @param gfyURL The URL of a Gfy to be looked up on Gfycat.
 @param completion A completion block that runs on the main queue, returning an NSURL object to the Gfycat HTML5 link and an NSError object.
 */
+ (void)getExistingGfycatLink:(NSURL*)gfyURL completion:(AEGfycatCompletionBlock)completion;

/**
 Looks up the NSURL provided for a gfy (Gfycat-formatted GIF) on Gfycat and returns a BOOL value representing the Gfy's existence, along with an NSError (just in case).
 
 @param gfyURL The URL of an image to be searched up on Gfycat.
 @param completion A completion block that runs on the main queue, returning a BOOL value representing the gfy's existence and an NSError object.
 */
+ (void)gfycatExists:(NSURL*)url completion:(AEGfycatExistsCompletionBlock)completion;

/**
 Checks if the NSURL provided is a valid gif link.
 
 @param url The URL to be checked.
 */
+ (BOOL)isGIF:(NSURL*)url;

/**
 Checks if the NSURL provided is a valid Gfycat link.
 
 @param url The URL to be checked.
 */
+ (BOOL)isGfycatLink:(NSURL*)url;
@end
