//
//  MGScoreTransmitter.h
//  MyGame
//
//  Created by Marina Osés Merino on 07/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MGNumbersDelegate.h"
#import "MGScoreBoard.h"
#import "MGLifesController.h"


@interface MGScoreTransmitter : NSObject {
    MGNumbersDelegate *_numbersDelegate;
    MGScoreBoard *_scoreBoard;
    MGLifesController *_lifesController;
    
}

@property (nonatomic, retain) MGNumbersDelegate *numbersDelegate;
@property (nonatomic, retain) MGScoreBoard *scoreBoard;
@property (nonatomic, retain) MGLifesController *lifesController;


- (id)initWithScoreBoard:(MGScoreBoard *)score_board NumbersDelegate:(MGNumbersDelegate *)numbers_delegate LifesController:(MGLifesController *)lifes_controller;
- (void)aNewDuckIsSaved;
- (void)aNewLeafIsTaken;
- (void)aNewBeeIsTaken;
- (void)aNewBirdIsKilled;
- (void)aNewDuckIsKilled;
- (void)theTransformerHasCrossedTheLine;
- (BOOL)isPossibleToCollideWithLeaves;
@end
