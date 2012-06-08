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
        startPoint = start_point;
        scaleOfPresentation = scale_of_presentation;
    }
    return self;
}

//Devuelvo un array con los elementos prefectamente preparados para agreagar a pantalla
- (NSMutableArray *)createNumberWithValuesInArray:(NSInteger)value {
    NSMutableArray *arrayWithTokens = [self.tokenExtractor extractTokens:value];
    NSMutableArray *arrayWithAllNumber = [[NSMutableArray alloc] initWithCapacity:[arrayWithTokens count]];
    NSMutableArray *arrayWithFigures = [self.multipleFigureDecorator createFiguresWithValuesInArray:arrayWithTokens];
    MGPoint nextPointToStart = startPoint;
    CGFloat previousMidWidth = 0.0;
    for (MGSceneObject *fig in arrayWithFigures) {
        fig.translation = MGPointMake(nextPointToStart.x + previousMidWidth + CGRectGetMidX(fig.meshBounds), nextPointToStart.y, 0.0);
        fig.scale = scaleOfPresentation;
        
        [arrayWithAllNumber addObject:fig];
        
        previousMidWidth = CGRectGetMidX(fig.meshBounds);
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
