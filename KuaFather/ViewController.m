//
//  ViewController.m
//  KuaFather
//
//  Created by 陈学芹 on 2016/10/16.
//  Copyright © 2016年 爱T社. All rights reserved.
//

#import "ViewController.h"
#import "GeoPointCompass.h"
#import "Sun.h"

@interface ViewController ()

@end
GeoPointCompass *geoPointCompass;
SunPoint *sunPoint;


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    // Create the image for the compass
    UIImageView *arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 375, 375)];
    arrowImageView.image = [UIImage imageNamed:@"compass2.png"];
    
    
    arrowImageView.center = self.view.center;
    arrowImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:arrowImageView];
    
    geoPointCompass = [[GeoPointCompass alloc] init];
    
    // Add the image to be used as the compass on the GUI
    [geoPointCompass setArrowImageView:arrowImageView];
    
    // add Sun Pointer
    UIImageView *sunImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 375, 375)];
    sunImageView.image = [UIImage imageNamed:@"sunarrow2.png"];
    
    sunImageView.center = self.view.center;
    
    [self.view addSubview:sunImageView];
    
    sunPoint = [[SunPoint alloc] init];
    
    // Add the image to be used as the compass on the GUI
    [sunPoint setArrowImageView:sunImageView];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
