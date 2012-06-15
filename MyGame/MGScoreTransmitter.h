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


@interface MGScoreTransmitter : NSObject {
    MGNumbersDelegate *_numbersDelegate;
    MGScoreBoard *_scoreBoard;
}

@property (nonatomic, retain) MGNumbersDelegate *numbersDelegate;
@property (nonatomic, retain) MGScoreBoard *scoreBoard;

- (id)initWithScoreBoard:(MGScoreBoard *)score_board NumbersDelegate:(MGNumbersDelegate *)numbers_delegate;
- (void)aNewDuckIsSaved;
- (void)aNewLeafIsTaken;
- (BOOL)isPossibleToCollideWithLeaves;
@end
