//
//  SHLMovie.m
//  MovieSearch_Assessment_ObjC
//
//  Created by Steve Lederer on 12/21/18.
//  Copyright © 2018 Steve Lederer. All rights reserved.
//

#import "SHLMovie.h"

@implementation SHLMovie

- (instancetype)initWithDictionary:(NSDictionary *)resultDictionary
{
    self = [super init];
    if (self) {
        NSString *title = resultDictionary[@"title"];
        NSString *overview = resultDictionary[@"overview"];
        NSNumber *voteAverage = resultDictionary[@"vote_average"];
        NSString *posterPath = resultDictionary[@"poster_path"];
        
        if (posterPath == (id)[NSNull null] || posterPath.length == 0 ) posterPath = @" ";
        
        if (![title isKindOfClass:[NSString class]] || ![overview isKindOfClass:[NSString class]] || ![voteAverage isKindOfClass:[NSNumber class]] || ![posterPath isKindOfClass:[NSString class]]) {
            return nil;
        }
        
        _title = title;
        _overview = overview;
        _voteAverage = voteAverage;
        _posterPath = posterPath;
    }
    return self;
}

@end
