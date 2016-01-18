//
//  ViewController.m
//  Spotlight_Demo
//
//  Created by 沈红榜 on 16/1/18.
//  Copyright © 2016年 沈红榜. All rights reserved.
//

#import "ViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <CoreSpotlight/CoreSpotlight.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view, typically from a nib.
    
    /**
     *   iOS9 以后需要修改 info.plist 
     */
    
    
    [self addSearchableItemWithImageUrl:@"http://h.hiphotos.baidu.com/image/pic/item/314e251f95cad1c8905ab6197c3e6709c93d512e.jpg" title:@"景甜" contentDescription:@"这是一张景甜的图片" keywords:@[@"景甜"] identifier:@"这个item的标志"];
    
}

/**
 *   @param urlString   图片的url
 *   @param title       title
 *   @param discription 描述
 *   @param identifier  每个item的标识，不能重复，否则会被覆盖
 */
- (void)addSearchableItemWithImageUrl:(NSString *)urlString title:(NSString *)title contentDescription:(NSString *)discription keywords:(NSArray *)keywords identifier:(NSString *)identifier {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        CSSearchableItemAttributeSet *set = [[CSSearchableItemAttributeSet alloc] initWithItemContentType:(NSString *)kUTTypeImage];
        
        set.title = title;
        set.keywords = keywords;
        
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
        set.thumbnailData = imageData;
        
        set.contentDescription = discription;
        
        CSSearchableItem *item = [[CSSearchableItem alloc] initWithUniqueIdentifier:identifier domainIdentifier:@"com.shb.spotlight" attributeSet:set];
        
        [[CSSearchableIndex defaultSearchableIndex] indexSearchableItems:@[item] completionHandler:^(NSError * _Nullable error) {
            if (error) {
                NSLog(@"添加失败");
            } else {
                NSLog(@"添加成功");
            }
        }];
    });
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
