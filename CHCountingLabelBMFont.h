//
//  CHCountingLabelBMFont.h
//
//  Created by Kojo Sugita on 13/02/23.
//
//

#import "CCLabelBMFont.h"

@protocol CHCountingLabelBMFontDelegate <NSObject>

- (void)didFinishCountAnimation:(id)sender;

@end

@interface CHCountingLabelBMFont : CCLabelBMFont {
    NSTimer *countTimer;
    NSInteger incremental;
    NSUInteger _from;
    BOOL _separated;
    NSNumberFormatter *formatter;
}

@property (nonatomic, assign) id<CHCountingLabelBMFontDelegate>delegate;

@property NSUInteger from;
@property NSUInteger to;
@property NSUInteger numberOfRotations;
@property float duration;
@property BOOL separated;

- (void)countAnimationStart:(float)_duration;
- (void)countAnimationStop;


@end
