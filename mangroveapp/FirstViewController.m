//
//  FirstViewController.m
//  mangroveapp
//
//  Created by Joel Oliveira on 12/01/14.
//  Copyright (c) 2014 Joel Oliveira. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    
    NSURL *nsUrl=[NSURL URLWithString:@"http://mangrove.com"];
    NSURLRequest *nsRequest=[NSURLRequest requestWithURL:nsUrl];
    [[self webView] loadRequest:nsRequest];
    
    [self setActivityIndicatorView:[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray]];
    [[self view] addSubview:[self activityIndicatorView]];
    
    [[self activityIndicatorView] setHidden:YES];
    
    
    [[self activityIndicatorView]  setCenter:CGPointMake( self.view.frame.size.width /2-5, self.view.frame.size.height /2-5)];
    
    [[self activityIndicatorView]  setContentMode:UIViewContentModeCenter];
    
    [[self activityIndicatorView]  startAnimating];
}


-(void)webViewDidStartLoad:(UIWebView *)webView{
    
    [[self activityIndicatorView] setHidden:NO];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    [[self activityIndicatorView] setHidden:YES];
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    ALERT_DIALOG(LSSTRING(@"title_webview_load_fail"), LSSTRING(@"message_webview_load_fail"));
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
