//
//  SHLMovieController.h
//  MovieSearch_Assessment_ObjC
//
//  Created by Steve Lederer on 12/21/18.
//  Copyright © 2018 Steve Lederer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SHLMovie.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SHLMovieController : NSObject

+(void)fetchAllMoviesForSearchTerm:(NSString *)searchTerm
                        completion:(void (^)(NSArray<SHLMovie *> *_Nullable movies))completion;

+(void)fetchPosterImageForMovie:(SHLMovie *)movie
                     completion:(void (^)(UIImage* _Nullable image))completion;

@end

NS_ASSUME_NONNULL_END
