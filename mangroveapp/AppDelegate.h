//
//  AppDelegate.h
//  mangroveapp
//
//  Created by Joel Oliveira on 12/01/14.
//  Copyright (c) 2014 Joel Oliveira. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NotificarePushLib.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, NotificarePushLibDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSMutableArray * tags;


-(void)getTags;
 
-(void)createTags:(NSArray *)tags;

-(void)deleteTag:(NSString *)tag;

@end
