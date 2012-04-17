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
}

@property (nonatomic, assign) UITouchPhase phase;
@property (nonatomic, assign) CGPoint location;


- (id)initWithUITouch:(UITouch *)uiTouch;
- (NSString *)description;


@end
