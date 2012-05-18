//
//  MGTimer.m
//  MyGame
//
//  Created by Marina Osés Merino on 18/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGTimeController.h"

@implementation MGTimeController

@synthesize updateCounter;

- (id)init {
    self = [super init];
    if (self) {
        self.updateCounter = 0;
    }
    return self;
}



@end
