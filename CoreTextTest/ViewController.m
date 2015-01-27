//
//  ViewController.m
//  CoreTextTest
//
//  Created by dengbin on 15/1/27.
//  Copyright (c) 2015年 IUAIJIA. All rights reserved.
//

#import "ViewController.h"
#import "CTView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"txt"];
    NSString* text = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
    
    NSAttributedString* aString =
    [[NSAttributedString alloc] initWithString:text];
    
    
    CTView *view=[[CTView alloc]initWithFrame:self.view.bounds];
        
    [view setAttString: aString];//添加显示的内容
    
    [view buildFrames];//绘制内容
    
    [self.view addSubview:view];

}
    // Do any additional setup after loading the view, typically from a nib.


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
