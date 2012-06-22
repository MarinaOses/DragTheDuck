//
//  MGNumberPresenter.m
//  MyGame
//
//  Created by Marina Osés Merino on 07/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGNumberPresenter.h"

@implementation MGNumberPresenter

@synthesize multipleFigureDecorator = _multipleFigureDecorator;
@synthesize tokenExtractor = _tokenExtractor;

- (id)initWithSceneController:(MGSceneController *)scene_controller StartAtPoint:(MGPoint)start_point ScaleOfPresentation:(MGPoint)scale_of_presentation {
    self = [super init];
    if (self) {
        _multipleFigureDecorator = [[MGMultipleFigureDecorator alloc] initWithSceneController:scene_controller];
        _tokenExtractor = [[MGTokenExtractor alloc] init];
        //El valor inicial de startPoint indica el punto en el que se situará el lado izquierdo del cuadrado que representa el número. 
        startPoint = start_point;
        scaleOfPresentation = scale_of_presentation;
    }
    return self;
}



//Devuelvo un array con los elementos pefectamente preparados para agreagar a pantalla
- (NSMutableArray *)createNumberObjectWithValue:(NSInteger)value {
    NSMutableArray *arrayWithTokens = [self.tokenExtractor extractTokens:value];
    NSMutableArray *arrayWithAllNumber = [[NSMutableArray alloc] initWithCapacity:[arrayWithTokens count]];
    NSMutableArray *arrayWithFigures = [self.multipleFigureDecorator createFiguresWithValuesInArray:arrayWithTokens];
    MGPoint nextPointToStart = startPoint;
    NSInteger positionOfNumberToAssign;
    if (startPoint.y == SAVED_DUCKS_SCORE_START_Y) {
        positionOfNumberToAssign = 1;
    }
    else {
        positionOfNumberToAssign = 2;
    }
    CGFloat previousMidWidth = 0.0;
    for (MGSceneObject *fig in arrayWithFigures) {
        fig.scale = scaleOfPresentation;
        fig.positionOfNumber = positionOfNumberToAssign;
        CGFloat actualMidWidth = CGRectGetWidth(fig.meshBounds)/2;
        fig.translation = MGPointMake(nextPointToStart.x + previousMidWidth + actualMidWidth, nextPointToStart.y, 0.0);
        
        
        [arrayWithAllNumber addObject:fig];
        
        previousMidWidth = actualMidWidth;
        nextPointToStart = fig.translation;
    }
    return [arrayWithAllNumber autorelease];
}


- (void)dealloc {
    [_multipleFigureDecorator release];
    [_tokenExtractor release];
    [super dealloc];
}
@end
