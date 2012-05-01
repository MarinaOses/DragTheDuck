//
//  MGTouch.h
//  MyGame
//
//  Created by Marina Osés Merino on 17/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MGTouch : NSObject {
    UITouchPhase _phase;
    CGPoint _location;
    NSUInteger _numberOfFingersOnTheScreen;
}

@property (nonatomic, assign) UITouchPhase phase;
@property (nonatomic, assign) CGPoint location;
@property (nonatomic, assign) NSUInteger numberOfFingersOnTheScreen;


- (id)initWithUITouch:(UITouch *)uiTouch andUIEvent:(UIEvent *)uiEvent;
- (NSString *)description;


@end
