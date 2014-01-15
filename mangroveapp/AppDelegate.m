//
//  AppDelegate.m
//  mangroveapp
//
//  Created by Joel Oliveira on 12/01/14.
//  Copyright (c) 2014 Joel Oliveira. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    [[NotificarePushLib shared] launch];
    [[NotificarePushLib shared] setDelegate:self];

    
#if TARGET_IPHONE_SIMULATOR
    
        [[NotificarePushLib shared] registerForWebsockets];
    
    if([launchOptions objectForKey:@"UIApplicationLaunchOptionsLocalNotificationKey"]){
        
        [[NotificarePushLib shared] handleOptions:[launchOptions objectForKey:@"UIApplicationLaunchOptionsLocalNotificationKey"]];
    }
    
#else
    
    [[NotificarePushLib shared] registerForRemoteNotificationsTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
    
    if([launchOptions objectForKey:@"UIApplicationLaunchOptionsRemoteNotificationKey"]){
        
        [[NotificarePushLib shared] handleOptions:[launchOptions objectForKey:@"UIApplicationLaunchOptionsRemoteNotificationKey"]];
        
    }
    
#endif
    
    [self setTags:[NSMutableArray array]];
    
    return YES;
}

#pragma APNS

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    //If you don't identify users you can just use this
    [[NotificarePushLib shared] registerDevice:deviceToken];

    [self getTags];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    
    NSLog(@"%@",error);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    [[NotificarePushLib shared] openNotification:userInfo];
}




#pragma WEBSOCKETS
-(void)notificarePushLib:(NotificarePushLib *)library didRegisterForWebsocketsNotifications:(NSString *)token{
    
    //If you don't identify users you can just use this
    [[NotificarePushLib shared] registerDeviceForWebsockets:token];
    
    [self getTags];
}

-(void)notificarePushLib:(NotificarePushLib *)library didFailToRegisterWebsocketNotifications:(NSError *)error{
    //You might want to reconnect again
    [[NotificarePushLib shared] registerForWebsockets];
}

-(void)notificarePushLib:(NotificarePushLib *)library didCloseWebsocketConnection:(NSString *)reason{
    //You might want to reconnect again
    [[NotificarePushLib shared] registerForWebsockets];
}

-(void)notificarePushLib:(NotificarePushLib *)library didReceiveWebsocketNotification:(NSDictionary *)info{
    
    [[NotificarePushLib shared] openNotification:info];
}


-(void)getTags{
    
    [[NotificarePushLib shared] getTags:^(NSDictionary *info) {

        [self setTags:[info objectForKey:@"tags"]];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"gotTags" object:nil];
        
    } errorHandler:^(NSError *error) {

    }];
}

-(void)createTags:(NSArray *)tags{
    
    [[NotificarePushLib shared] addTags:tags completionHandler:^(NSDictionary *info) {
        //
        [self getTags];
    } errorHandler:^(NSError *error) {
        //
    }];
}

-(void)deleteTag:(NSString *)tag{
    
    [[NotificarePushLib shared] removeTag:tag completionHandler:^(NSDictionary *info) {
        [self getTags];
    } errorHandler:^(NSError *error) {
        
    }];
}

							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
