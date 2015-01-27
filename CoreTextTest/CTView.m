//
//  CTView.m
//  CoreTextTest
//
//  Created by dengbin on 15/1/27.
//  Copyright (c) 2015年 IUAIJIA. All rights reserved.
//

#import "CTView.h"
#import <CoreText/CoreText.h>
@implementation CTView
{
    float _float_frameXOffset;
    float _float_frameYOffset;
    
    
    int   _int_countPage;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)buildFrames
{
    //偏移量 
    _float_frameXOffset = 20; //1
    _float_frameYOffset = 20;
    
    
    self.pagingEnabled = YES;
    self.delegate = self;
    self.frames = [NSMutableArray array];
    
    CGMutablePathRef path = CGPathCreateMutable(); //2
    CGRect textFrame = CGRectInset(self.bounds, _float_frameXOffset, _float_frameYOffset);
    NSLog(@"%@",NSStringFromCGRect(textFrame));

    
    CGPathAddRect(path, NULL, textFrame );
    
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)self.attString);
    
    int textPos = 0; //3
    int columnIndex = 0;
    
    while (textPos < [self.attString length]) { //4
        CGPoint colOffset = CGPointMake( (2*columnIndex+1)*_float_frameXOffset + columnIndex*(textFrame.size.width), 20 );
        CGRect colRect = CGRectMake(0, 0 , textFrame.size.width-10, textFrame.size.height-40);
        
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathAddRect(path, NULL, colRect);
        
        //use the column path
        CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(textPos, 0), path, NULL);
        CFRange frameRange = CTFrameGetVisibleStringRange(frame); //5
        
        //create an empty column view
        CTColumnView* content = [[CTColumnView alloc] initWithFrame: CGRectMake(0, 0, self.contentSize.width, self.contentSize.height)] ;
        
        content.backgroundColor = [UIColor clearColor];
        content.frame = CGRectMake(colOffset.x, colOffset.y, colRect.size.width, colRect.size.height) ;

        //set the column view contents and add it as subview
        [content setCTFrame:(__bridge id)frame];  //6
        [self.frames addObject: (__bridge id)frame];
        [self addSubview: content];
        
        //prepare for next frame
        textPos += frameRange.length;
        
        //CFRelease(frame);
        CFRelease(path);
        
        columnIndex++;
    }
    
    //set the total width of the scroll view
    _int_countPage = (columnIndex) ; //7
    self.contentSize = CGSizeMake(_int_countPage*self.bounds.size.width, textFrame.size.height);
    
    
    
    
}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int page=floor(((scrollView.contentOffset.x-scrollView.frame.size.width/2)/scrollView.frame.size.width)+2);
    
    NSLog(@"%d  %d",page ,_int_countPage);


}

//- (void)drawRect:(CGRect)rect
//{
//    [super drawRect:rect];
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    
//    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
//    CGContextTranslateCTM(context, 0, self.bounds.size.height);
//    CGContextScaleCTM(context, 1.0, -1.0);
//    
//    CGMutablePathRef path = CGPathCreateMutable(); //1   这里你需要创建一个用于绘制文本的路径区域
//    CGPathAddRect(path, NULL, self.bounds );
//    
//    
//    
//   // MarkupParser* p = [[MarkupParser alloc] init] ;
//   // NSAttributedString* attString = [p attrStringFromMarkup: @"Hello \"red\">core text \"blue\">world!"];
//
//   // NSAttributedString* attString = [[NSAttributedString alloc]
//   //                                   initWithString:@"Hello core text world!"] ; //2
//    
//    CTFramesetterRef framesetter =
//    CTFramesetterCreateWithAttributedString((CFAttributedStringRef)self.attString); //3 管理您的字体引用和文本绘制帧
//    
//    CTFrameRef frame =
//    CTFramesetterCreateFrame(framesetter,
//                             CFRangeMake(0, [self.attString length]), path, NULL);
//    
//    CTFrameDraw(frame, context); //4
//    
//    CFRelease(frame); //5
//    CFRelease(path);
//    CFRelease(framesetter);
//}
@end
