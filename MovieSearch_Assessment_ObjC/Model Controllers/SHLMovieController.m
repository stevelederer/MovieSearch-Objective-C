//
//  SHLMovieController.m
//  MovieSearch_Assessment_ObjC
//
//  Created by Steve Lederer on 12/21/18.
//  Copyright © 2018 Steve Lederer. All rights reserved.
//

#import "SHLMovieController.h"
#import "SHLMovie.h"

@implementation SHLMovieController

// MARK: - Static URLs

+(NSURL *)movieURL
{
    return [NSURL URLWithString:@"https://api.themoviedb.org/"];
}

+(NSURL *)posterImageURL
{
    return [NSURL URLWithString:@"https://image.tmdb.org"];
}

// MARK: - API Key function

+ (NSString *)apiKey
{
    static NSString *apiKey = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURL *apiKeysURL = [[NSBundle mainBundle] URLForResource:@"APIKeys" withExtension:@"plist"];
        if (!apiKeysURL) {
            NSLog(@"🔑🔑🔑🔑🔑🔑Error! APIKeys file not found!🔑🔑🔑🔑🔑🔑");
            return;
        }
        NSDictionary *apiKeys = [[NSDictionary alloc] initWithContentsOfURL: apiKeysURL];
        apiKey = apiKeys[@"APIKey"];
        NSLog(@"API Key Is: %@", apiKey);
    });
    return apiKey;
}


// MARK: - Fetch Functions

+ (void)fetchAllMoviesForSearchTerm:(NSString *)searchTerm completion:(void (^)(NSArray<SHLMovie *> * _Nullable))completion
{
    // URL Setup
    
    NSURL *startingURL = [[[[SHLMovieController movieURL] URLByAppendingPathComponent:@"3"] URLByAppendingPathComponent:@"search"] URLByAppendingPathComponent:@"movie"];
    NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:startingURL resolvingAgainstBaseURL:YES];
    NSURLQueryItem *apiKey = [[NSURLQueryItem alloc] initWithName:@"api_key" value:[self apiKey]];
    NSURLQueryItem *searchQuery = [[NSURLQueryItem alloc] initWithName:@"query" value:searchTerm];
    [urlComponents setQueryItems:@[apiKey, searchQuery]];
    NSURL *movieSearchURL = urlComponents.URL;
    NSLog(@"📡📡📡 Search URL︓ %@", movieSearchURL);
    
    //DataTask + RESUME
    
    [[[NSURLSession sharedSession] dataTaskWithURL:movieSearchURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"There was an error with the dataTask %@", error.localizedDescription);
            return completion(nil);
        }
        if (!data) {
            NSLog(@"No movie data to decode %@", error.localizedDescription);
            return completion(nil);
        }
        
        NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        if (error) {
            NSLog(@" Error serializing json %@", error.localizedDescription);
            return completion(nil);
        }
        
        NSArray *resultsArray = jsonDictionary[@"results"];
        NSMutableArray *movies = [NSMutableArray array];
        for (NSDictionary *movieDictionary in resultsArray) {
            SHLMovie *movie = [[SHLMovie alloc] initWithDictionary:movieDictionary];
            if (movie) {
                [movies addObject: movie];
            }
        }
        completion(movies);
    }] resume];
}

+ (void)fetchPosterImageForMovie:(SHLMovie *)movie completion:(void (^)(UIImage * _Nullable))completion
{
    NSURL *imageURL = [[[[[SHLMovieController posterImageURL] URLByAppendingPathComponent:@"t"] URLByAppendingPathComponent:@"p"] URLByAppendingPathComponent:@"w500"] URLByAppendingPathComponent:[movie posterPath]];
    NSLog(@"📷 Image URL ︓ %@", imageURL);
    
    if (!imageURL) {
        NSLog(@"🚨🚨🚨 No imageURL Found⁉️‼️");
        return completion(nil);
    }
    
    [[[NSURLSession sharedSession] dataTaskWithURL:imageURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"There was an error with the fetchImage dataTask %@", error.localizedDescription);
        }
        if (!data) {
            NSLog(@"No image data to decode in image dataTask %@", error.localizedDescription);
        }
        
        UIImage *posterImage = [[UIImage alloc] initWithData:data];
        if (posterImage) {
            completion(posterImage);
        }
        else {
            return completion(nil);
        }
    }] resume];
}

@end
