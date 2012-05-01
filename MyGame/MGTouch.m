//
//  MGTouch.m
//  MyGame
//
//  Created by Marina Osés Merino on 17/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGTouch.h"

@implementation MGTouch

@synthesize phase = _phase;
@synthesize location = _location;
@synthesize numberOfFingersOnTheScreen = _numberOfFingersOnTheScreen;


- (id)initWithUITouch:(UITouch *)uiTouch andUIEvent:(UIEvent *)uiEvent {
    self = [super init];
    if (self) {
        self.phase = [uiTouch phase];
        self.location = [uiTouch locationInView:[uiTouch view]];
        self.numberOfFingersOnTheScreen = [[uiEvent touchesForView:[uiTouch view]] count];
    }
    return self;
}

- (NSString *)description {
    NSString *phaseAsString;
    switch (self.phase) {
        case UITouchPhaseBegan:
            phaseAsString = @"Began";
            break;
        case UITouchPhaseMoved:
            phaseAsString = @"Moved";
            break;
        case UITouchPhaseEnded:
            phaseAsString = @"Ended";
            break;
        default:
            phaseAsString = @"failed";
            break;
    }
    return [NSString stringWithFormat:@"phase: %@ | location: (%d,%d)", phaseAsString, (int)self.location.x, (int)self.location.y];
}

- (void)dealloc {
    [super dealloc];
}

@end
