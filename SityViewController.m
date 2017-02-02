//
//  ViewController.m
//  searchWether
//
//  Created by mike on 29.01.17.
//  Copyright © 2017 smartage. All rights reserved.
//

#import "SityViewController.h"

@interface SityViewController ()


@end

@implementation SityViewController{
    NSArray *searchResults;
    NSString *sities;
    NSArray *sities_ua;
}
@synthesize sityTitle;
@synthesize tempWeather;
@synthesize imageWeather;
@synthesize windWeather;
@synthesize sityName;
@synthesize sityNameUa;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    sityTitle.text = sityNameUa;
    tempWeather.text = @"";
    windWeather.text = @"";
    
    [self getRespons:sityName];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getRespons:(NSString *)sity{
    
    
    NSString *string1 = [NSString stringWithFormat:@"%@%@", @"http://api.apixu.com/v1/current.json?key=9e1bc123d8834ed781015902173001&q=", sity];
    NSURL *url = [NSURL URLWithString:string1];
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession* session = [NSURLSession sessionWithConfiguration:sessionConfig delegate:self delegateQueue:nil];
    
    [[session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        @try {
            NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            if ([NSJSONSerialization isValidJSONObject:responseDic])
            {
                NSDictionary *current = [responseDic objectForKey: @"current"];
                if ( ( ![current isEqual:[NSNull null]] )) {
                    NSString *cloud = [current objectForKey: @"cloud"];
                    int val = [cloud intValue];
                    NSString *temp = [current objectForKey: @"temp_c"];
                    NSString *tempC = [NSString stringWithFormat:@"Температура: %@ C", temp];
                    
                    NSString *wind_kph = [current objectForKey: @"wind_kph"];
                    NSString *windKmH = [NSString stringWithFormat:@"Швидкість вітру: %@ км/год", wind_kph];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        switch (val) {
                            case 0:
                                imageWeather.image = [UIImage imageNamed:@"sun.png"];
                                break;
                            case 1:
                                imageWeather.image = [UIImage imageNamed:@"cloud_w.png"];
                                break;
                                
                            default:
                                imageWeather.image = [UIImage imageNamed:@"cloud_b.png"];
                                break;
                        }
                        self.tempWeather.text = tempC;
                        self.windWeather.text = windKmH;
                    });
                }
            }
        } @catch (NSException *exception) {
            NSLog(@"Error: %@",exception.name);
        }
        
    }] resume];
}
@end
