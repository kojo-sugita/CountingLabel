//
//  WPCountingLabel.h
//  cocos2dtest
//
//  Created by Kojo Sugita on 13/02/11.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "CCLabelTTF.h"

@protocol WPCountingLabelDelegate <NSObject>

- (void)didFinishCountAnimation;

@end

@interface WPCountingLabel : CCLabelTTF {
    NSTimer *countTimer;
    NSInteger incremental;
}

@property (nonatomic, assign) id<WPCountingLabelDelegate>delegate;

@property NSInteger from;
@property NSInteger to;
@property NSInteger numberOfRotations;
@property float duration;

- (void)countAnimationStart:(float)_duration;
- (void)countAnimationStop;

@end
