//
//  ScoreBoard.h
//  MyGame
//
//  Created by Marina Osés Merino on 29/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MGScoreTransmitter.h"

@interface MGScoreBoard : NSObject {
    NSInteger killedBirds;
    NSInteger takenLeaves;
    NSInteger savedDucks;
    NSInteger lostDucks;
    BOOL doesLeavesCounterActive;
    
    MGScoreTransmitter *_scoreTransmitter;
}



@property (nonatomic, assign) NSInteger takenLeaves;
@property (nonatomic, retain) MGScoreTransmitter *scoreTransmitter;

- (id)initWithScoreTransmitter:(MGScoreTransmitter *)score_transmitter;
- (void)resetTakenLeaves;
- (void)addNewTakenLeaf;
@end
