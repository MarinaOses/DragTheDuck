//
//  MGGenerator.h
//  MyGame
//
//  Created by Marina Osés Merino on 17/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MGTimeController.h"

@protocol MGGenerator <NSObject>
@required
- (NSArray *)createWave;
- (CGFloat)getWaitTimeToNextWave;

@end
