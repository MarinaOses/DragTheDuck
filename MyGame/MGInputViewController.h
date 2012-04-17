//
//  MGInputViewController.h
//  MyGame
//
//  Created by Marina Osés Merino on 06/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGTouch.h"

@interface MGInputViewController : UIViewController {
    NSMutableSet *_touchEvents;
}

@property (nonatomic, retain) NSMutableSet *touchEvents;

- (void)clearEvents;

@end
