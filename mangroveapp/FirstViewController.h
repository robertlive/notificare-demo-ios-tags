//
//  FirstViewController.h
//  mangroveapp
//
//  Created by Joel Oliveira on 12/01/14.
//  Copyright (c) 2014 Joel Oliveira. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstViewController : UIViewController <UIWebViewDelegate>

@property (nonatomic, strong) IBOutlet UIWebView * webView;
@property (nonatomic, strong) UIActivityIndicatorView * activityIndicatorView;

@end
