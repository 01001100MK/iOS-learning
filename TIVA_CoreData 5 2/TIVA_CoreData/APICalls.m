//
//  APICalls.m
//  Tiva Test 3
//
//  Created by TIVA on 10/7/16.
//  Copyright © 2016 TIVA. All rights reserved.
//

#import "APICalls.h"

@implementation APICalls

// Unlike weather api, this api return object!? not array
+ (NSMutableDictionary *)GetRecommendationsForMovieID:(NSString *) movieID
{
    NSMutableDictionary *resultArray = [[NSMutableDictionary alloc] init];
    
    NSString *apiUrl = [[NSString alloc] init];
    apiUrl = [NSString stringWithFormat:@"%@%@%@",
              @"https://api.themoviedb.org/3/movie/", movieID, @"/recommendations?api_key=81d7640dffed48055b1803be5b452893&language=en-US"];

    NSURL *url = [[NSURL alloc] initWithString:apiUrl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                    cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30.0];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    // Use Sync
    NSHTTPURLResponse *urlResponse = nil;
    NSError *error = nil;
    
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request
                                                 returningResponse:&urlResponse error:&error];
    
    if (error.code == 0) {
        resultArray = [NSJSONSerialization JSONObjectWithData:responseData
                                                      options:NSJSONReadingMutableLeaves error:&error];
        // NSLog(@"RESULT IS %@", resultArray);
    }
    else {
        NSLog(@" Error is %@", error);
    }
    
    return resultArray;
}

+ (NSData *)GetImageForRecommendedMovie:(NSString *)imageURL
{
    NSData *resultData = [[NSData alloc] init];
    
    NSString *apiUrl = [[NSString alloc] init];
    apiUrl = [NSString stringWithFormat:@"%@%@", @"https://image.tmdb.org/t/p/w300", imageURL];
    
    NSURL *url = [[NSURL alloc] initWithString:apiUrl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30.0];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    // Use Sync
    NSHTTPURLResponse *urlResponse = nil;
    NSError *error = nil;
    
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request
                                                 returningResponse:&urlResponse error:&error];
    
    if (error.code == 0){
        resultData = responseData;
    }
    else{
        NSLog(@" Error is %@", error);
    }
    
    return resultData;
}


// Unlike weather api, this api return object!? not array
+ (NSMutableDictionary *)GetDetailForMovieID:(NSString *) movieID
{
    NSMutableDictionary *resultArray = [[NSMutableDictionary alloc] init];
    
    // NSString *apiUrl = @"https://api.themoviedb.org/3/movie/550/recommendations?api_key=81d7640dffed48055b1803be5b452893&language=en-US";
    
    NSString *apiUrl = [[NSString alloc] init];
    apiUrl = [NSString stringWithFormat:@"%@%@%@",
              @"https://api.themoviedb.org/3/movie/", movieID, @"?api_key=81d7640dffed48055b1803be5b452893&language=en-US"];
    
    //    NSLog(@"%@", apiUrl);
    NSURL *url = [[NSURL alloc] initWithString:apiUrl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30.0];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    // Use Sync
    NSHTTPURLResponse *urlResponse = nil;
    NSError *error = nil;
    
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request
                                                 returningResponse:&urlResponse error:&error];
    
    if (error.code == 0) {
        resultArray = [NSJSONSerialization JSONObjectWithData:responseData
                                                      options:NSJSONReadingMutableLeaves error:&error];
        // NSLog(@"RESULT IS %@", resultArray);
    }
    else {
        NSLog(@" Error is %@", error);
    }
    
    return resultArray;
}


+ (NSManagedObjectContext *)managedObjectContext
{
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

@end
