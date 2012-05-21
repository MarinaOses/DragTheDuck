//
//  MGTimer.h
//  MyGame
//
//  Created by Marina Osés Merino on 18/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MGNotification.h"
#import "MGConfiguration.h"

@interface MGTimeController : NSObject {
    NSInteger currentUpdate;
    NSMutableArray *_notificationArray;
    NSMutableArray *_notificationsToAdd;
    NSMutableArray *_notificationsToRemove;
    BOOL activated;
}

@property (nonatomic, assign) NSInteger currentUpdate;
@property (nonatomic, retain) NSMutableArray *notificationArray;
@property (nonatomic, retain) NSMutableArray *notificationsToAdd;
@property (nonatomic, retain) NSMutableArray *notificationsToRemove;
@property (nonatomic, assign) BOOL activated;

- (id)init;
- (void)start;
- (void)anUpdateHappens;
- (void)createAndAddNotificationIn:(NSInteger)seconds WithObject:(id)object Selector:(SEL)selector;
- (void)stop;

@end
