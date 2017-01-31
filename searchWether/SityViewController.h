//
//  UIViewController_SityViewController.h
//  searchWether
//
//  Created by mike on 31.01.17.
//  Copyright © 2017 smartage. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SityViewController : UIViewController<NSURLSessionDataDelegate,NSURLSessionDelegate,NSURLSessionTaskDelegate,NSURLSessionStreamDelegate>;

@property (weak, nonatomic) IBOutlet UIImageView *imageWeather;
@property (weak, nonatomic) IBOutlet UILabel *sityTitle;
@property (weak, nonatomic) IBOutlet UILabel *tempWeather;
@property (weak, nonatomic) IBOutlet UILabel *windWeather;
    
@property (weak, nonatomic) NSString *sityName;
@property (weak, nonatomic) NSString *sityNameUa;

-(void)getRespons:(NSString *)sity;

@end
