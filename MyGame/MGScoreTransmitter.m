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

- (id)initWithNumbersDelegate:(MGNumbersDelegate *)numbers_delegate {
    self = [super init];
    if (self) {
        self.numbersDelegate = numbers_delegate;
    }
    return self;
}

- (void)transmiteToNumbersDelegateScore:(NSInteger)score {
    [self.numbersDelegate updateTheMarkerWith:score];
}

- (void)dealloc {
    [_numbersDelegate release];
    [super dealloc];
}

@end
