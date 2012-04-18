//
//  MGInputViewController.m
//  MyGame
//
//  Created by Marina Osés Merino on 06/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGInputViewController.h"

@interface MGInputViewController()
- (void)createTouchCopiesFromSet:(NSSet *)uiTouchesSet andEvent:(UIEvent *)uiEvent;
@end


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
    [self createTouchCopiesFromSet:touches andEvent:event];
    if ([[event touchesForView:[self view]] count] > 1) {
        NSLog(@"***********%d active touches", [[event touchesForView:[self view]] count]);
    }
    
}

//cuando uno o más dedos se mueven por la vista o ventana
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [self createTouchCopiesFromSet:touches andEvent:event];
    if ([[event touchesForView:[self view]] count] > 1) {
        NSLog(@"_______________%d active touches", [[event touchesForView:[self view]] count]);
    }
}

//cuando uno o más dedos se levantan de la vista o ventana
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self createTouchCopiesFromSet:touches andEvent:event];
    if ([[event touchesForView:[self view]] count] > 1) {
        NSLog(@"<<<<<<<<<<<<<<<%d active touches", [[event touchesForView:[self view]] count]);
    }
    
}

- (void)createTouchCopiesFromSet:(NSSet *)uiTouchesSet andEvent:(UIEvent *)uiEvent {
    for (UITouch *aTouch in uiTouchesSet) {
        MGTouch *touchCopy = [[MGTouch alloc] initWithUITouch:aTouch andUIEvent:uiEvent];
        [self.touchEvents addObject:touchCopy];
        [touchCopy release];
    }   
}

- (CGRect)screenRectFromMeshRect:(CGRect)meshRect atPoint:(CGPoint)meshCenter {
    
}


- (void)dealloc {
    [_touchEvents dealloc];
    [super dealloc];
}

@end
