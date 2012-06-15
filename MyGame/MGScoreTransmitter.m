//
//  MGScoreTransmitter.m
//  MyGame
//
//  Created by Marina Osés Merino on 07/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGScoreTransmitter.h"

@implementation MGScoreTransmitter

@synthesize numbersDelegate =_numbersDelegate;
@synthesize scoreBoard = _scoreBoard;

- (id)initWithScoreBoard:(MGScoreBoard *)score_board NumbersDelegate:(MGNumbersDelegate *)numbers_delegate {
    self = [super init];
    if (self) {
        self.numbersDelegate = numbers_delegate;
        self.scoreBoard = score_board;
    }
    return self;
}

- (void)aNewDuckIsSaved {
    [self.scoreBoard addNewSavedDuck];
    [self.numbersDelegate updateTheMarkerWith:self.scoreBoard.savedDucks];
}

- (void)aNewLeafIsTaken {
    [self.scoreBoard addNewTakenLeaf];    
}

- (BOOL)isPossibleToCollideWithLeaves {
    BOOL isPossible = YES;
    if (self.scoreBoard.takenLeaves >= MAX_TAKEN_LEAVES) {
        isPossible = NO;
    }
    return isPossible;
}



- (void)dealloc {
    [_numbersDelegate release];
    [_scoreBoard release];
    [super dealloc];
}

@end
