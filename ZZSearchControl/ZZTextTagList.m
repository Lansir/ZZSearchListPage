//
//  ZZTextTagList.m
//  ZZSearchControl
//
//  Created by heheda on 2016/11/10.
//  Copyright © 2016年 呵呵嗒. All rights reserved.
//

#define LABEL_MARGIN 8.0f
#define BOTTOM_MARGIN 8.0f
#define CORNER_RADIUS 8.0f
#define FONT_SIZE 12.0f
#define HORIZONTAL_PADDING 8.0f
#define VERTICAL_PADDING 6.0f

#import "ZZTextTagList.h"

@implementation ZZTextTagList

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}
- (NSInteger)getHotKeyHeightWithArray:(NSArray *)arr
{
    textArray = [NSArray arrayWithArray:arr];
    hotKeyHeight = [self initLabel];
    return hotKeyHeight;
}

- (NSInteger )initLabel
{
    CGSize textSize;
    CGRect previousFrame = CGRectZero;
    BOOL isHasPreviousFrame = NO;
    for (NSString *text in textArray) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        textSize = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT)
                                      options:NSStringDrawingUsesLineFragmentOrigin
                                   attributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:FONT_SIZE],NSFontAttributeName,nil]
                                      context:nil].size;
        textSize.width = textSize.width + 8;
        textSize.height = textSize.height + 4;
        if (isHasPreviousFrame) {
            //非首行首个关键字
            CGRect nowRect = CGRectZero;
            if (previousFrame.origin.x + previousFrame.size.width + textSize.width + LABEL_MARGIN > SCREEN_WIDTH - 20) {
                //需换行
                nowRect.origin = CGPointMake(0, previousFrame.origin.y + textSize.height + BOTTOM_MARGIN);
                hotKeyHeight += textSize.height + BOTTOM_MARGIN;
            }else{
                //无需换行
                nowRect.origin = CGPointMake(previousFrame.origin.x + previousFrame.size.width + LABEL_MARGIN, previousFrame.origin.y);
            }
            nowRect.size = textSize;
            btn.frame = nowRect;
        }else{
            //首行首个关键字
            btn.frame = CGRectMake(0.0f, 0.0, textSize.width, textSize.height);
            hotKeyHeight = textSize.height;
        }
        previousFrame = btn.frame;
        isHasPreviousFrame = YES;
        btn.titleLabel.font = [UIFont systemFontOfSize:FONT_SIZE];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor lightGrayColor];
        [btn setTitle:text forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(onBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn.layer setMasksToBounds:YES];
        [btn.layer setCornerRadius:CORNER_RADIUS];
        [btn.layer setBorderColor:[UIColor clearColor].CGColor];
        [btn.layer setBorderWidth:1];
        [self addSubview:btn];
    }
    hotKeyHeight = hotKeyHeight + 16;
    return hotKeyHeight;
}

- (void)onBtnClick:(UIButton *)sender
{
    NSString *text = sender.titleLabel.text;
    if (self.block) {
        self.block(text);
    }
}
@end
