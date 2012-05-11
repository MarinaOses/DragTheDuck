//
//  MGBirdDestroyer.m
//  MyGame
//
//  Created by Marina Osés Merino on 10/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGBirdDestroyer.h"

@implementation MGBirdDestroyer

@synthesize birdsToRemove = _birdsToRemove;

- (id)init {
    self = [super init];
    if (self) {
        _birdsToRemove = [[NSMutableArray alloc] init];
    }
    return self;
}


- (void)clearBirdsToRemove {
    [self.birdsToRemove removeAllObjects];
}

- (void)markToRemoveBird:(MGBird *)bird {
    [self.birdsToRemove addObject:bird];
}

- (void)dealloc {
    [_birdsToRemove release];
    [super dealloc];
}





@end
