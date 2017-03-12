//
//  ViewController.m
//  AwsomeLayOut
//
//  Created by 陈凯 on 2017/3/1.
//  Copyright © 2017年 陈凯. All rights reserved.
//

#import "ViewController.h"
#import "CardLayoutVC.h"

@interface ViewController ()
@property (strong, nonatomic) NSArray *demos;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.demos = @[
                   @{@"title":@"卡片布局", @"controller":CardLayoutVC.class},
                   ];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.demos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCellId"];
    cell.textLabel.text = self.demos[indexPath.row][@"title"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Class vcClass = self.demos[indexPath.row][@"controller"];
    UIViewController *vc = [vcClass new];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
