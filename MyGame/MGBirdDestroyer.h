//
//  MGBirdDestroyer.h
//  MyGame
//
//  Created by Marina Osés Merino on 10/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MGBird.h"

@interface MGBirdDestroyer : NSObject {
    NSMutableArray *_birdsToRemove;
}

@property (nonatomic, retain) NSMutableArray *birdsToRemove;

- (void)clearBirdsToRemove;
- (void)markToRemoveBird:(MGBird *)bird;

@end
