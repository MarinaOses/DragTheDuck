//
//  MGValidator.m
//  MyGame
//
//  Created by Marina Osés Merino on 06/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGValidator.h"

@implementation MGValidator

- (id)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

+ (BOOL)isCorrect:(NSInteger)value {
    if (0 <= value && value <= 9) {
        return YES;
    }
    return NO;
}

- (void)dealloc {
    [super dealloc];
}

@end
