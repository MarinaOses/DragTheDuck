//
//  MGNotification.m
//  MyGame
//
//  Created by Marina Osés Merino on 21/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGNotification.h"

@implementation MGNotification
@synthesize updateToNotificate;
@synthesize target = _target;
@synthesize methodToCall;


- (id)initWitUpdateToNotificate:(NSInteger)update_to_notificate Target:(id)id_target MethodToCall:(SEL)method_to_call {
    self = [super init];
    if (self) {
        self.updateToNotificate = update_to_notificate;
        self.target = id_target;
        self.methodToCall = method_to_call;
    }
    return self;
}



@end
