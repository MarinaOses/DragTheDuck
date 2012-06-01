//
//  ScoreBoard.h
//  MyGame
//
//  Created by Marina Osés Merino on 29/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MGScoreBoard : NSObject {
    NSInteger killedBirds;
    NSInteger takenLeaves;
    NSInteger savedDucks;
    NSInteger lostDucks;
    BOOL doesLeavesCounterActive;
}

@property (nonatomic, assign) NSInteger takenLeaves;
- (id)init;
- (void)resetTakenLeaves;
- (void)addNewTakenLeaf;
@end
