//
//  AEGfycatHandler.m
//  AEGfycatHandler
//
//  Created by Akshay Easwaran on 6/27/14.
//  Copyright (c) 2014 Akshay Easwaran. All rights reserved.
//

#import "AEGfycatHandler.h"

static NSString * const kAEErrorDomain = @"com.akeaswaran.AEGfycatHandler";
static int const kAEGfycatErrorCode = 443433;

@implementation AEGfycatHandler

+ (void)convertGIFToGfycat:(NSURL*)gifURL completion:(AEGfycatCompletionBlock)completion {
    //Example gifURL: http://i.imgur.com/CG2EfIX.gif
    
    if ([AEGfycatHandler isGIF:gifURL]) {
        NSString *gfycatTranscodeString = [NSString stringWithFormat:@"http://upload.gfycat.com/transcode/%@?fetchUrl=%@",[AEGfycatHandler random],[gifURL.absoluteString stringByReplacingOccurrencesOfString:@"http://" withString:@""]];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:gfycatTranscodeString]];
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            if (!connectionError) {
                NSError *jsonError;
                id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&jsonError];
                if (!jsonError && [jsonObject isKindOfClass:[NSDictionary class]]) {

                    NSDictionary *jsonDict = (NSDictionary*)jsonObject;
                    NSString *gfyCatName = [jsonDict[@"gfyName"] copy];
                    NSString *gfyCatLink = jsonDict[@"mp4Url"];
                    
                    if (gfyCatName.length == 0) {
                        completion(gifURL,[NSError errorWithDomain:kAEErrorDomain code:kAEGfycatErrorCode userInfo:@{NSLocalizedDescriptionKey : @"Gfycat conversion failure - Switching to base link."}]);
                    } else {
                        NSURL *gfycatURL = [NSURL URLWithString:gfyCatLink];
                        completion(gfycatURL,nil);
                    }
                } else {
                    completion(nil,jsonError);
                }
                
            } else {
                completion(nil,connectionError);
            }
        }];
    }
}

+ (void)getExistingGfycatLink:(NSURL*)gfyURL completion:(AEGfycatCompletionBlock)completion {
    //Example gfyURL: http://gfycat.com/ScaryGrizzledComet
    
    if ([AEGfycatHandler isGfycatLink:gfyURL]) {
        NSString *gifString = [gfyURL.absoluteString stringByReplacingOccurrencesOfString:@"http://gfycat.com/" withString:@""];
        NSString *gfycatTranscodeString = [NSString stringWithFormat:@"http://gfycat.com/cajax/get/%@",[gifString stringByReplacingOccurrencesOfString:@"/" withString:@""]];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:gfycatTranscodeString]];
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            if (!connectionError) {
                
                NSError *jsonError;
                id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&jsonError];

                if (!jsonError && [jsonObject isKindOfClass:[NSDictionary class]]) {
 
                    NSDictionary *gfyObject = (NSDictionary*)jsonObject;
                    NSDictionary *jsonDict = gfyObject[@"gfyItem"];
                    NSString *gfyCatName = [jsonDict[@"gfyName"] copy];
                    NSString *gfyCatLink = jsonDict[@"mp4Url"];
                    
                    if (gfyCatName.length == 0) {
                        completion(gfyURL,[NSError errorWithDomain:kAEErrorDomain code:kAEGfycatErrorCode userInfo:@{NSLocalizedDescriptionKey : @"Gfycat lookup failure - Switching to base link."}]);
                    } else {
                        NSURL *gfycatURL = [NSURL URLWithString:gfyCatLink];
                        completion(gfycatURL,nil);
                    }
                } else {
                    completion(nil,jsonError);
                   
                }
                
                
            } else {
                completion(nil,connectionError);
            }
        }];
    }
    
}

+ (void)gfycatExists:(NSURL*)url completion:(AEGfycatExistsCompletionBlock)completion {
    if ([AEGfycatHandler isGIF:url]) {
        NSString *encodedURL = [url.absoluteString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *encodedGfyString = [NSString stringWithFormat:@"http://gfycat.com/cajax/checkUrl/%@",encodedURL];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:encodedGfyString]];
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            if (!connectionError) {
                
                NSError *jsonError;
                id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&jsonError];
                
                if (!jsonError && [jsonObject isKindOfClass:[NSDictionary class]]) {
                    
                    NSDictionary *jsonDict = (NSDictionary*)jsonObject;;
                    NSString *gfyCatName = [jsonDict[@"gfyName"] copy];
                    
                    if (gfyCatName.length == 0) {
                        completion(NO,[NSError errorWithDomain:kAEErrorDomain code:kAEGfycatErrorCode userInfo:@{NSLocalizedDescriptionKey : @"Gfycat search failure - No Gfycat found. Please use convertGIFToGfycat: to convert this GIF."}]);
                    } else {
                        completion(YES,nil);
                    }
                } else {
                    completion(NO,jsonError);
                    
                }
                
                
            } else {
                completion(NO,connectionError);
            }
        }];

    } else {
        completion(NO, [NSError errorWithDomain:kAEErrorDomain code:kAEGfycatErrorCode userInfo:@{NSLocalizedDescriptionKey : @"Gfycat search failure - No GIF at URL"}]);
    }
    
    
}


#pragma mark - Helper methods

+ (BOOL)isGfycatLink:(NSURL*)url {
    NSString *link = url.absoluteString;
    if(
	   [link rangeOfString:@"gfycat" options:NSCaseInsensitiveSearch].location != NSNotFound
       && [link rangeOfString:@".gif" options:NSCaseInsensitiveSearch].location == NSNotFound)
		return true;
	else
		return false;
}

+ (BOOL)isGIF:(NSURL*)url {
    NSString *link = url.absoluteString;
    if ([link rangeOfString:@".gif" options:NSCaseInsensitiveSearch].location != NSNotFound) {
        return YES;
    } else {
        return NO;
    }
}

/**
 Returns a string of 10 random alphanumeric characters.
 */
+ (NSString*)random {
    NSString* text = @"";
    NSString* possible = @"A B C D E F G H I J K L M N O P Q R S T U V W X Y Z a b c d e f g h i j k l m n o p q r s t u v w x y z 0 1 2 3 4 5 6 7 8 9";
    NSArray *possibleChars = [possible componentsSeparatedByString:@" "];
    int indices = (int)possibleChars.count - 1;
    for( int i = 0; i < 10; i++ ) {
        int rand = arc4random_uniform(indices);
        text = [text stringByAppendingString:[possibleChars objectAtIndex:rand]];
    }
    
    return text;
}

@end
