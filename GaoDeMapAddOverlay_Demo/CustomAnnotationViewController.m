//
//  CustomAnnotationViewController.m
//  Category_demo
//
//  Created by songjian on 13-3-21.
//  Copyright (c) 2013年 songjian. All rights reserved.
//

#import "CustomAnnotationViewController.h"

#import "CusAnnotationView.h"

#import <MAMapKit/MAMapKit.h>

#define AppKey @"398394b219d4e99054315783a9f57da7"
#define kLongitude 120.431412
#define kLatitude 36.071660

@interface CustomAnnotationViewController () <MAMapViewDelegate>
/** 地图 */
@property (nonatomic,strong) MAMapView *mapView;
@end
@implementation CustomAnnotationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //配置用户Key
    [MAMapServices sharedServices].apiKey = AppKey;
    
    self.mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds))];
    self.mapView.delegate = self;
    
    self.mapView.showsUserLocation = YES;
    
    self.mapView.centerCoordinate = CLLocationCoordinate2DMake(kLatitude, kLongitude);
    
    [self.view addSubview:_mapView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    /* Add a annotation on map center. */
    [self addAnnotationWithCooordinate:self.mapView.centerCoordinate];
}

-(void)addAnnotationWithCooordinate:(CLLocationCoordinate2D)coordinate
{
    MAPointAnnotation *annotation = [[MAPointAnnotation alloc] init];
    annotation.coordinate = coordinate;
    [self.mapView addAnnotation:annotation];
}


#pragma mark - MAMapViewDelegate

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *customReuseIndetifier = @"customReuseIndetifier";
        
        CusAnnotationView *annotationView = (CusAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:customReuseIndetifier];
        
        if (annotationView == nil)
        {
            annotationView = [[CusAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:customReuseIndetifier];
        }
        annotationView.infoText = [NSString stringWithFormat:@"市南区\n321"];
        return annotationView;
    }
    return nil;
}

#pragma mark - Action Handle

- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view
{
    NSLog(@"点击了");
    self.mapView.zoomLevel ++;
    NSLog(@"%lf",self.mapView.zoomLevel);
    [self.mapView removeAnnotations:self.mapView.annotations];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self addAction];
    });
}

/** 随机产生一个坐标点 */
- (CGPoint)randomPoint
{
    CGPoint randomPoint = CGPointZero;
    
    randomPoint.x = arc4random() % (int)(CGRectGetWidth(self.view.bounds));
    randomPoint.y = arc4random() % (int)(CGRectGetHeight(self.view.bounds));
    
    return randomPoint;
}

- (void)addAction {
    
    CLLocationCoordinate2D randomCoordinate = [self.mapView convertPoint:[self randomPoint] toCoordinateFromView:self.view];
    
    [self addAnnotationWithCooordinate:randomCoordinate];
}

-(void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation
updatingLocation:(BOOL)updatingLocation
{
    if(updatingLocation)
    {
        //取出当前位置的坐标
        NSLog(@"latitude : %f,longitude: %f",userLocation.coordinate.latitude,userLocation.coordinate.longitude);
    }
}
@end
