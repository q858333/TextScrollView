//
//  CTView.h
//  CoreTextTest
//
//  Created by dengbin on 15/1/27.
//  Copyright (c) 2015年 IUAIJIA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CTColumnView.h"
@interface CTView : UIScrollView
@property (strong, nonatomic) NSAttributedString* attString;
@property (strong, nonatomic) NSMutableArray* frames; //每行内容


- (void)buildFrames;
@end
