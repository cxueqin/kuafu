//
//  Sun.h
//  KuaFather
//
//  Created by 陈学芹 on 2016/10/16.
//  Copyright © 2016年 爱T社. All rights reserved.
//

#ifndef Sun_h
#define Sun_h

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>

@interface SunPoint : NSObject <CLLocationManagerDelegate>

@property (nonatomic, retain) CLLocationManager* locationManager;

@property (nonatomic, retain) UIImageView *arrowImageView;

@property (nonatomic, retain) NSTimer *timer;


@end


#endif /* Sun_h */
