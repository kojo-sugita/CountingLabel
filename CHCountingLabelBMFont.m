//
//  CHCountingLabelBMFont.m
//
//  Created by Kojo Sugita on 13/02/23.
//
//

#import "CHCountingLabelBMFont.h"

@implementation CHCountingLabelBMFont

@synthesize to;
@synthesize numberOfRotations;
@synthesize duration;

/**
 * 開始数値のgetter
 */
- (NSUInteger)from
{
    return _from;
}

/**
 * 開始数値のsetter
 */
- (void)setFrom:(NSUInteger)from
{
    self.string = [NSString stringWithFormat:@"%d", from];
    _from = from;
}

/**
 * 数値をカンマで区切るかを指定するプロパティのgetter
 */
- (BOOL)separated
{
    return _separated;
}

/**
 * 数値をカンマで区切るかを指定するプロパティのsetter
 */
- (void)setSeparated:(BOOL)separated
{
    _separated = separated;
    if (_separated) {
        // 数値を3桁ごとカンマ区切りにするように設定
        formatter = [[NSNumberFormatter alloc] init];
        [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
        [formatter setGroupingSeparator:@","];
        [formatter setGroupingSize:3];

    } else {
        formatter = nil;

    }
}

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
    
    // 開始と終了が同じなら即座に抜ける
    if (self.from == self.to) {
        [self countAnimationStop];
    }
    
    // 増分を取得する
    incremental = [self getIncremental];
    if (incremental == 0) {
        incremental = 1;
    }
    
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
    countTimer = nil;
    
    if ([self.delegate respondsToSelector:@selector(didFinishCountAnimation:)]) {
        [self.delegate didFinishCountAnimation:self];
    }
}

/**
 * タイマーが発火したとき
 */
- (void)doTimer:(NSTimer *)timer
{
    // カンマをとる
    NSString *valueString = [self.string stringByReplacingOccurrencesOfString:@"," withString:@""];
    NSInteger value = valueString.intValue;
    value += incremental;
    
    if (value > self.to) {
        value = self.to;
        [self countAnimationStop];
    }

    // カンマで区切るか?
    if (self.separated) { // yes
        NSNumber *num = [NSNumber numberWithInteger:value];
        self.string = [formatter stringFromNumber:num];
        
    } else {
        self.string = [NSString stringWithFormat:@"%d", value];
    }
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
