//
//  MGTimer.h
//  MyGame
//
//  Created by Marina Osés Merino on 18/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MGTimeController : NSObject {
    NSInteger updateCounter;
}

@property (nonatomic, assign) NSInteger updateCounter;

- (id)init;

@end
