//
//  MGTokenExtractor.m
//  MyGame
//
//  Created by Marina Osés Merino on 07/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGTokenExtractor.h"

@implementation MGTokenExtractor

- (id)init {
    self = [super init];
    if (self) {
    }
    return self;
}

//Separa un string en sus componentes (NSString)
- (NSMutableArray *)extractTokens:(NSInteger)value {
    NSString *valueToString = [NSString stringWithFormat:@"%d", value];
    NSMutableArray *arrayWithTokens = [[NSMutableArray alloc] initWithCapacity:[valueToString length]];
    for (int i = 0; i < [valueToString length]; i++) {
        NSString *ichar  = [NSString stringWithFormat:@"%c", [valueToString characterAtIndex:i]];
        [arrayWithTokens addObject:ichar];
    }
    return [arrayWithTokens autorelease];
}


- (void)dealloc {
    [super dealloc];
}

@end
