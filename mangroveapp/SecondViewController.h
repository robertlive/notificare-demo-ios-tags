//
//  SecondViewController.h
//  mangroveapp
//
//  Created by Joel Oliveira on 12/01/14.
//  Copyright (c) 2014 Joel Oliveira. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) IBOutlet UITableView * tblView;
@property (nonatomic, strong) IBOutlet UINavigationBar * navigationBar;
@property (nonatomic, strong) NSMutableArray * tags;
@property (nonatomic, strong) NSMutableArray * tmpLog;

@end
