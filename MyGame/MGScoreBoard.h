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
@property (nonatomic, assign) NSInteger savedDucks;
@property (nonatomic, assign) NSInteger killedBirds;

- (id)init;
- (void)resetTakenLeaves;
- (void)resetKilledBirds;
- (void)addNewTakenLeaf;
- (void)addNewSavedDuck;
- (void)addNewKilledBird;
@end
