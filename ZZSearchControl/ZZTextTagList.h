//
//  ZZTextTagList.h
//  ZZSearchControl
//
//  Created by heheda on 2016/11/10.
//  Copyright © 2016年 呵呵嗒. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^cellBlock) (NSString *labelText);

@interface ZZTextTagList : UIView
{
    NSArray  *textArray;
    NSInteger hotKeyHeight;
}
@property (nonatomic, strong) cellBlock block;

- (NSInteger)getHotKeyHeightWithArray:(NSArray *)arr;

@end
