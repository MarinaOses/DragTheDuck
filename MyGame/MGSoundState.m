//
//  MGSoundState.m
//  MyGame
//
//  Created by Marina Osés Merino on 10/09/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGSoundState.h"

@implementation MGSoundState
@synthesize gainLevel;


- (id) init
{
	self = [super init];
	if(nil != self)
	{
		self.gainLevel = 1.0f;
	}
	return self;
}



- (void)applyState {
    
}

- (void)update {
    
}

@end
