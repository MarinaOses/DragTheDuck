//
//  MGInputViewController.h
//  MyGame
//
//  Created by Marina Osés Merino on 06/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EAGLView.h"
#import "MGTouch.h"
#import "MGPoint.h"



@interface MGInputViewController : UIViewController {
    NSMutableSet *_touchEvents; //Guarda objetos de tipo MGTouch
}

@property (nonatomic, retain) NSMutableSet *touchEvents;

- (void)clearEvents;
- (CGRect)screenRectFromMeshRect:(CGRect)meshRect atPoint:(CGPoint)meshCenter;
- (MGPoint)meshCenterFromMGTouchLocation:(CGPoint)mgTouchLocation;
- (NSUInteger)supportedInterfaceOrientations;

@end
