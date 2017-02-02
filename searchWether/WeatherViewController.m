//
//  ViewController.m
//  searchWether
//
//  Created by mike on 29.01.17.
//  Copyright © 2017 smartage. All rights reserved.
//

#import "WeatherViewController.h"
#import "SityViewController.h"

@interface WeatherViewController ()
    
@end

@implementation WeatherViewController{
    NSArray *searchResults;
    NSArray *sities;
    NSArray *sities_ua;
}
@synthesize jsonData;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    sities = [NSArray arrayWithObjects:@"Simferopol", @"Vinnitsa",@"Lutsk", @"Dnipro",@"Donets'k", @"Zhytomyr",@"Uzhgorod", @"Zaporizhzhia",@"Ivano-Frankivsk", @"Kiev",@"Kropivnitskiy", @"Lugansk",@"Lviv", @"Mykolayiv",@"Odessa", @"Poltava",@"Rivne",@"Sumy", @"Ternopil",@"Kharkov", @"Herson",@"Khmelnytskyi", @"Cherkassy",@"Chernovtsy",@"Chernihiv",   nil];
    sities_ua = [NSArray arrayWithObjects:@"Сімферополь", @"Вінниця",@"Луцьк", @"Дніпро",@"Донецьк", @"Житомир",@"Ужгород", @"Запоряжжя",@"Івано-Францівськ", @"Київ",@"Кропивницький", @"Луганськ",@"Львів", @"Миколаїв",@"Одеса", @"Полтава",@"Рівне",@"Суми", @"Тернопіль",@"Харків", @"Херсон",@"Хмельницьк", @"Черкаси",@"Чернівці",@"Чернігів",   nil];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [sities count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIndex = @"regions";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndex];
    
    if(cell == nil){
         cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIndex];
    }
    cell.textLabel.text = [sities_ua objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = @">";
    cell.imageView.image = [UIImage imageNamed:@"sun.png"];
    [self getRespons:[sities objectAtIndex:indexPath.row] toCell:cell];
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)getRespons:(NSString *)sity toCell:(UITableViewCell *)cell{
    NSString *string1 = [NSString stringWithFormat:@"%@%@", @"http://api.apixu.com/v1/current.json?key=9e1bc123d8834ed781015902173001&q=", sity];
    NSURL *url = [NSURL URLWithString:string1];
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession* session = [NSURLSession sessionWithConfiguration:sessionConfig delegate:self delegateQueue:nil];
    
    [[session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        if ([NSJSONSerialization isValidJSONObject:responseDic])
        {
            NSDictionary *current = [responseDic objectForKey: @"current"];
            if ( ( ![current isEqual:[NSNull null]] )) {
                NSString *cloud = [current objectForKey: @"cloud"];
                int val = [cloud intValue];
                dispatch_async(dispatch_get_main_queue(), ^{
                    switch (val) {
                        case 0:
                            break;
                        case 1:
                            cell.imageView.image = [UIImage imageNamed:@"cloud_w.png"];
                            break;
                            
                        default:
                            cell.imageView.image = [UIImage imageNamed:@"cloud_b.png"];
                            break;
                    }
                });
            }
        }
    }] resume];
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"sityWeather"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        SityViewController * sityView = segue.destinationViewController;
        sityView.sityName = [sities objectAtIndex:indexPath.row];
        sityView.sityNameUa = [sities_ua objectAtIndex:indexPath.row];
    }
}
@end
