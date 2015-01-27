//
//  CTView.m
//  CoreTextTest
//
//  Created by dengbin on 15/1/27.
//  Copyright (c) 2015年 IUAIJIA. All rights reserved.
//

#import "CTView.h"
#import <CoreText/CoreText.h>
#import "MarkupParser.h"
@implementation CTView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    CGMutablePathRef path = CGPathCreateMutable(); //1   这里你需要创建一个用于绘制文本的路径区域
    CGPathAddRect(path, NULL, self.bounds );
    
    
    
   // MarkupParser* p = [[MarkupParser alloc] init] ;
   // NSAttributedString* attString = [p attrStringFromMarkup: @"Hello \"red\">core text \"blue\">world!"];

   // NSAttributedString* attString = [[NSAttributedString alloc]
   //                                   initWithString:@"Hello core text world!"] ; //2
    
    CTFramesetterRef framesetter =
    CTFramesetterCreateWithAttributedString((CFAttributedStringRef)self.attString); //3 管理您的字体引用和文本绘制帧
    
    CTFrameRef frame =
    CTFramesetterCreateFrame(framesetter,
                             CFRangeMake(0, [self.attString length]), path, NULL);
    
    CTFrameDraw(frame, context); //4
    
    CFRelease(frame); //5
    CFRelease(path);
    CFRelease(framesetter);
}
@end
