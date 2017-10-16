//
//  LaunchVC.m
//  Geminy Cricket
//
//  Created by Ryan Higgins on 10/15/17.
//  Copyright © 2017 Higgnet. All rights reserved.
//

#import "LaunchVC.h"

@interface LaunchVC ()

@end

@implementation LaunchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blueColor];
    
    UIImage *image = [UIImage imageNamed:@"LaunchVCImage.png"];
    UIImageView *launchImage = [[UIImageView alloc] initWithImage:image];
    launchImage.frame = CGRectMake(0,
                                   0,
                                   self.view.frame.size.width,
                                   self.view.frame.size.height);
    [self.view addSubview:launchImage];
}


@end
