//
//  MGTexturedButton.h
//  MyGame
//
//  Created by Marina Osés Merino on 03/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGButton.h"

@interface MGTexturedButton : MGButton {
    MGTexturedQuad *_upQuad;
    MGTexturedQuad *_downQuad;
}


- (id)initWithSceneController:(MGSceneController *)scene_controller UpKey:(NSString *)up_key downKey:(NSString *)down_key;

@property (nonatomic, retain) MGTexturedQuad *upQuad;
@property (nonatomic, retain) MGTexturedQuad *downQuad;

@end
