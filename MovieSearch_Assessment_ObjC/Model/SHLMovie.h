//
//  SHLMovie.h
//  MovieSearch_Assessment_ObjC
//
//  Created by Steve Lederer on 12/21/18.
//  Copyright © 2018 Steve Lederer. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SHLMovie : NSObject

@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, copy, readonly) NSString *overview;
@property (nonatomic, copy, readonly) NSNumber *voteAverage;
@property (nonatomic, copy, readonly, nullable) NSString *posterPath;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
