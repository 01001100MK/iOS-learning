//
//  ApiCalls.h
//  MoviePrototype1
//
//  Created by TIVA on 10/21/16.
//  Copyright © 2016 TIVA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ApiCalls : NSObject

+ (NSMutableDictionary *)GetPopularMovies;
+ (NSData *)GetImageDataForMovieUrl:(NSString *)imageUrl;
+ (NSMutableDictionary *)GetUserCreatedList:(NSString *)listId;

@end
