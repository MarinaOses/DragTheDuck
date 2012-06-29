//
//  MGFinger.m
//  MyGame
//
//  Created by Marina Osés Merino on 29/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGFinger.h"

@implementation MGFinger
@synthesize isFree = _isFree;

- (id)init {
    self = [super init];
    if (self) {
        self.isFree = YES;
    }
    return self;
}

- (void)dealloc {
    [super dealloc];
}


@end
