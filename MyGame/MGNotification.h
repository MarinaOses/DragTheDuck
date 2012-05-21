//
//  MGNotification.h
//  MyGame
//
//  Created by Marina Osés Merino on 21/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MGNotification : NSObject {
    NSInteger updateToNotificate;
    id _target;
    SEL methodToCall;
}

@property (nonatomic, assign) NSInteger updateToNotificate;
@property (nonatomic, retain) id target;
@property (nonatomic, assign) SEL methodToCall;


- (id)initWitUpdateToNotificate:(NSInteger)update_to_notificate Target:(id)id_target MethodToCall:(SEL)method_to_call;
@end
