//
//  MGTimer.m
//  MyGame
//
//  Created by Marina Osés Merino on 18/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGTimeController.h"

@implementation MGTimeController

@synthesize currentUpdate;
@synthesize notificationArray = _notificationArray;
@synthesize notificationsToAdd = _notificationsToAdd;
@synthesize notificationsToRemove = _notificationsToRemove;
@synthesize activated;

- (id)init {
    self = [super init];
    if (self) {
        self.activated = NO;
        _notificationArray = [[NSMutableArray alloc] init];
        _notificationsToAdd = [[NSMutableArray alloc] init];
        _notificationsToRemove = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)reset {
    self.currentUpdate = 0;
    [self.notificationArray removeAllObjects]; 
}

- (void)activate {
    self.activated = YES;
}

- (void)start {
    [self reset];
    [self activate];
}

- (void)addNotificationsFrom:(NSMutableArray *)newNotifications {
    [self.notificationArray addObjectsFromArray:newNotifications];
    [newNotifications removeAllObjects];
}

- (void)removeNotificationsFrom:(NSMutableArray *)oldNotifications {
    [self.notificationArray removeObjectsInArray:oldNotifications];
    [oldNotifications removeAllObjects];
}


- (void)anUpdateHappens {
    if (self.activated) {
        self.currentUpdate++;
        //NSLog(@"current = %d", self.currentUpdate);
        for (MGNotification *n in self.notificationArray) {
            if (n.updateToNotificate == currentUpdate) {
                [n.target performSelector:n.methodToCall];
                [self.notificationsToRemove addObject:n];
            }
        }
        [self removeNotificationsFrom:self.notificationsToRemove];
        [self addNotificationsFrom:self.notificationsToAdd];
    }
}


- (void)addNotification:(MGNotification *)notification {
    if ([notification.target respondsToSelector:notification.methodToCall]) {
        [self.notificationsToAdd addObject:notification];
    }
    else {
         NSLog(@"El objeto de tipo %@ no responde al selector %@", NSStringFromClass([notification.target class]),NSStringFromSelector(notification.methodToCall));
    }
}

- (void)createAndAddNotificationIn:(NSInteger)seconds WithObject:(id)object Selector:(SEL)selector {
    NSInteger update_to_notificate = self.currentUpdate + (seconds * MAXIMUM_FRAME_RATE);
    MGNotification *notification = [[MGNotification alloc] initWitUpdateToNotificate:update_to_notificate Target:object MethodToCall:selector];
    [self addNotification:notification];
    [notification release];
}

- (void)deactivate {
    self.activated = NO;
}



- (void)dealloc {
    [_notificationArray release];
    [_notificationsToAdd release];
    [super dealloc];
}



@end
