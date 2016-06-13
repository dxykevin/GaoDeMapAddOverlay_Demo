//
//  CusAnnotationView.m
//  MAMapKit_static_demo
//
//  Created by songjian on 13-10-16.
//  Copyright (c) 2013年 songjian. All rights reserved.
//

#import "CusAnnotationView.h"
//#import "CustomCalloutView.h"

#define kWidth  90.f
#define kHeight 90.f

@interface CusAnnotationView ()

@property (nonatomic, strong) UILabel *label;
@end

@implementation CusAnnotationView

#pragma mark - Override

- (void)setInfoText:(NSString *)infoText {
   
    self.label.text = infoText;
}

- (NSString *)infoText {
    
    return self.label.text;
}

#pragma mark - Life Cycle

- (id)initWithAnnotation:(id<MAAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.bounds = CGRectMake(0.f, 0.f, kWidth, kHeight);
        
        self.backgroundColor = [UIColor clearColor];
        
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight)];
        self.label.layer.cornerRadius = kWidth / 2;
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.textColor = [UIColor whiteColor];
        self.label.numberOfLines = 2;
        self.label.layer.backgroundColor = [UIColor blueColor].CGColor;
        [self addSubview:self.label];
    }
    
    return self;
}

@end
