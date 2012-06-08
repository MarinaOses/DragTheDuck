//
//  MGScoreTransmitter.h
//  MyGame
//
//  Created by Marina Osés Merino on 07/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MGNumbersDelegate.h"


@interface MGScoreTransmitter : NSObject {
    MGNumbersDelegate *_numbersDelegate;
}

@property (nonatomic, retain) MGNumbersDelegate *numbersDelegate;

- (id)initWithNumbersDelegate:(MGNumbersDelegate *)numbers_delegate;
- (void)transmiteToNumbersDelegateScore:(NSInteger)score;

@end
