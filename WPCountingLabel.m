//
//  WPCountingLabel.m
//  cocos2dtest
//
//  Created by Kojo Sugita on 13/02/11.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "WPCountingLabel.h"

@implementation WPCountingLabel

@synthesize delegate;

@synthesize from;
@synthesize to;
@synthesize numberOfRotations;
@synthesize duration;

/**
 * カウントアニメーションを開始する
 */
- (void)countAnimationStart:(float)_duration
{
    self.duration = _duration;

    // パラメータが不正か?
    if (![self isCorrectParametor]) { // yes
        // 抜ける
        return;
    }

    // 増分を取得する
    incremental = [self getIncremental];
    
    // create timer
    countTimer = [NSTimer scheduledTimerWithTimeInterval:duration
                                                  target:self
                                                selector:@selector(doTimer:)
                                                userInfo:nil
                                                 repeats:YES
     ];
}

/**
 * カウントアニメーションを終了する
 */
- (void)countAnimationStop
{
    [countTimer invalidate];
    
    if ([self.delegate respondsToSelector:@selector(didFinishCountAnimation)]) {
        [self.delegate didFinishCountAnimation];        
    }
}

/**
 * タイマーが発火したとき
 */
- (void)doTimer:(NSTimer *)timer
{
    NSInteger value = self.string.intValue;
    value += incremental;
    
    if (value >= self.to) {
        value = self.to;
        [self countAnimationStop];
    }
    
    self.string = [NSString stringWithFormat:@"%d", value];
}

/**
 * 増分値を取得する
 */
- (NSInteger)getIncremental
{
    NSInteger diff = self.to - self.from;
    return (NSInteger)floor(diff / self.numberOfRotations);
}

/**
 * パラメータが正常か否かをチェックする
 * @retval YES パラメータは不正
 * @retval NO パラメータは正常
 */
- (BOOL)isCorrectParametor
{
    // タイマースピードが指定されていないか?
    if (self.duration < 0) { // yes
        return NO;
    }
    
    // 回転数が指定されていないか?
    if (self.numberOfRotations <= 0) {
        return NO;
    }
    
    NSInteger diff = self.to - self.from;

    // 開始値と終了値が異常か?
    if (diff < 0) { // yes
        return NO;
    }

    return YES;
}

@end
