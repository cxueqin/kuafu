//
//  Sun.m
//  KuaFather
//
//  Created by 陈学芹 on 2016/10/16.
//  Copyright © 2016年 爱T社. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Sun.h"

#define RadiansToDegrees(radians)(radians * 180.0/M_PI)
#define DegreesToRadians(degrees)(degrees * M_PI / 180.0)

@implementation SunPoint
float angle1;

- (id) init {
    self = [super init];
    
    if (self) {
        self.locationManager = [[CLLocationManager alloc] init];
        if ([CLLocationManager locationServicesEnabled])
        {
            // Configure and start the LocationManager instance
            self.locationManager.delegate = self;
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
            self.locationManager.distanceFilter = 100.0f;
            
            [self.locationManager startUpdatingLocation];
            [self.locationManager startUpdatingHeading];
        }
    }
    
    self.timer = [NSTimer timerWithTimeInterval:60 target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
    //必须添加到主循环中才可定时刷新
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
    return self;
}


#pragma mark - LocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"new Location : %@",[newLocation description]);
    
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    NSLog(@"Error : %@",[error localizedDescription]);
    
}

// magneticHeading 手机朝向偏离地磁正北方向的角度， trueHeading 手机朝向偏离正北角度
- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading
{
    [self updateSunPoint:newHeading];
}

-(void) updateSunPoint:(CLHeading *)newHeading
{
    NSLog(@"New Heading :%@", newHeading);
    
    float direction = newHeading.magneticHeading;
    
    if (direction > 180)
    {
        direction = 360 - direction;
    }
    else
    {
        direction = 0 - direction;
    }
    
    NSDate *currentTime = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSCalendarUnitHour | NSCalendarUnitMinute) fromDate:currentTime];
    NSInteger hour = [components hour];
    NSInteger minute = [components minute];
    
    NSLog(@"hour :%ld minute: %ld", (long)hour, (long)minute);
    float sundir = 360*(hour*60+minute)/(24*60);
    NSLog(@"hour :%ld minute: %ld sundir: %f", (long)hour, (long)minute, sundir);
    direction = direction+ sundir;
    
    // Rotate the arrow image
    if (self.arrowImageView)
    {
        [UIView animateWithDuration:3.0f animations:^{
            self.arrowImageView.transform = CGAffineTransformMakeRotation(DegreesToRadians(direction) + angle1);
        }];
    }
}

-(void) updateTime
{
    CLHeading *newHeading = [self.locationManager heading];
    
    NSLog(@"updateTime");
    if (newHeading != nil) {
        [self updateSunPoint:newHeading];
    }
}
@end
