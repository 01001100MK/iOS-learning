//
//  APICalls.h
//  Tiva Test 3
//
//  Created by TIVA on 10/7/16.
//  Copyright © 2016 TIVA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface APICalls : NSObject

+ (NSMutableDictionary *)GetRecommendationsForMovieID:(NSString *)movieID;
+ (NSData *)GetImageForRecommendedMovie:(NSString *)imageURL;
+ (NSMutableDictionary *)GetDetailForMovieID:(NSString *)movieID;

+ (NSManagedObjectContext *)managedObjectContext;

@end
