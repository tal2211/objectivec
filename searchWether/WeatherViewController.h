//
//  ViewController.h
//  searchWether
//
//  Created by mike on 29.01.17.
//  Copyright © 2017 smartage. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeatherViewController : UITableViewController <UITableViewDelegate,UITableViewDataSource,NSURLSessionDataDelegate,NSURLSessionDelegate,NSURLSessionTaskDelegate,NSURLSessionStreamDelegate> {
    NSMutableData *jsonData;
    
}

@property (nonatomic, retain) NSMutableData *jsonData;

-(void)getRespons:(NSString *)sity toCell:(UITableViewCell *)cell;
@end
