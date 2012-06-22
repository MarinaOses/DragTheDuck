//
//  ScoreBoard.m
//  MyGame
//
//  Created by Marina Osés Merino on 29/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGScoreBoard.h"

@implementation MGScoreBoard

@synthesize takenLeaves;
@synthesize savedDucks;
@synthesize killedBirds;

- (id)init {
    self = [super init];
    if (self) {
        killedBirds = 0;
        takenLeaves = 0;
        savedDucks = 0;
        lostDucks = 0;
        doesLeavesCounterActive = YES;
        
    }
    return self;
}

- (void)resetTakenLeaves {
    takenLeaves = 0;
}

- (void)resetKilledBirds {
    killedBirds = 0;
}

- (void)addNewTakenLeaf {
    takenLeaves++;
}

- (void)addNewSavedDuck {
    savedDucks++;
}

- (void)addNewKilledBird {
    killedBirds++;
}

- (void)dealloc {
    [super dealloc];
}
@end
