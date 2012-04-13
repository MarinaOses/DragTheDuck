//
//  MGInputViewController.m
//  MyGame
//
//  Created by Marina Osés Merino on 06/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGInputViewController.h"

@implementation MGInputViewController

@synthesize touchEvents = _touchEvents;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.touchEvents = [[NSMutableSet alloc] init];
    }
    return self;
}

#pragma mark Touch Events Handlers

//Borra todos los toques almacenados en el set
- (void)clearEvents {
    [self.touchEvents removeAllObjects];
}

//cuando uno o más dedos tocan la vista o ventana
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	// just store them all in the big set.
	[self.touchEvents addObjectsFromArray:[touches allObjects]];
}

//cuando uno o más dedos se mueven por la vista o ventana
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	// just store them all in the big set.
	[self.touchEvents addObjectsFromArray:[touches allObjects]];
}

//cuando uno o más dedos se levantan de la vista o ventana
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	// just store them all in the big set.
	[self.touchEvents addObjectsFromArray:[touches allObjects]];
}

- (void)dealloc {
    [_touchEvents dealloc];
    [super dealloc];
}

@end
