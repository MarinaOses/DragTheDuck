//
//  MGNumberPresenter.h
//  MyGame
//
//  Created by Marina Osés Merino on 07/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MGMultipleFigureDecorator.h"
#import "MGTokenExtractor.h"

@interface MGNumberPresenter : NSObject {
    MGMultipleFigureDecorator *_multipleFigureDecorator;
    MGTokenExtractor *_tokenExtractor;
    //Representa el punto en el que el número debe comenzar, no representa traslaciones
    MGPoint startPoint;
    MGPoint scaleOfPresentation;
}

@property (nonatomic, retain) MGMultipleFigureDecorator *multipleFigureDecorator;
@property (nonatomic, retain) MGTokenExtractor *tokenExtractor;

- (id)initWithSceneController:(MGSceneController *)scene_controller StartAtPoint:(MGPoint)start_point ScaleOfPresentation:(MGPoint)scale_of_presentation;
- (NSMutableArray *)createNumberObjectWithValue:(NSInteger)value;

@end
