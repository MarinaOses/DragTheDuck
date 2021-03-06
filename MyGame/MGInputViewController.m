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
        _touchEvents = [[NSMutableSet alloc] init];
    }
    return self;
}

#pragma mark - Touch Events Handlers

//Borra todos los toques almacenados en el set
- (void)clearEvents {
    [self.touchEvents removeAllObjects];
}

//cuando uno o más dedos tocan la vista o ventana
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self createTouchCopiesFromSet:touches andEvent:event];
}

//cuando uno o más dedos se mueven por la vista o ventana
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [self createTouchCopiesFromSet:touches andEvent:event];
}

//cuando uno o más dedos se levantan de la vista o ventana
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self createTouchCopiesFromSet:touches andEvent:event];
}


#pragma mark - Crear copias de los toques en touchEvents para guardar sus valores reales


- (void)createTouchCopiesFromSet:(NSSet *)uiTouchesSet andEvent:(UIEvent *)uiEvent {
    for (UITouch *aTouch in uiTouchesSet) {
        MGTouch *touchCopy = [[MGTouch alloc] initWithUITouch:aTouch andUIEvent:uiEvent];
        [self.touchEvents addObject:touchCopy];
        [touchCopy release];
    }   
}

#pragma mark - Funciones de traduccion entre pantalla y proyección

//Se debe tener en cuenta que los ejes sobre los que se dibuja el mesh y los ejes del propio dispositivo son distintos 
- (CGRect)screenRectFromMeshRect:(CGRect)meshRect atPoint:(CGPoint)meshCenter {
    CGPoint screenCenter = CGPointZero;
    CGPoint screenRectOrigin = CGPointZero;
    //NSLog(@"MidX=%f",CGRectGetMidX(self.view.frame));
    //NSLog(@"MidY=%f",CGRectGetMidY(self.view.frame));

    screenCenter.x = meshCenter.y + (CGRectGetMidX(self.view.frame));
    screenCenter.y = meshCenter.x + (CGRectGetMidY(self.view.frame));
    screenRectOrigin.x = screenCenter.x - (CGRectGetHeight(meshRect) / 2);
    screenRectOrigin.y = screenCenter.y - (CGRectGetWidth(meshRect) / 2);
    return CGRectMake(screenRectOrigin.x, screenRectOrigin.y, CGRectGetHeight(meshRect), CGRectGetWidth(meshRect));
}

//Traduce una localización de un touch de pantalla a coordenadas de proyección
- (MGPoint)meshCenterFromMGTouchLocation:(CGPoint)mgTouchLocation {
    MGPoint meshCenter = MGPointMake(0, 0, 0); 
    meshCenter.x = mgTouchLocation.y - (CGRectGetMidY(self.view.frame));
    meshCenter.y = mgTouchLocation.x - (CGRectGetMidX(self.view.frame));
    meshCenter = MGPointMake(meshCenter.x, meshCenter.y, 0.0);
    return meshCenter;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationPortraitUpsideDown;
}

- (void)dealloc {
    [_touchEvents dealloc];
    [super dealloc];
}

@end
