//
//  TagsCell.m
//  mangroveapp
//
//  Created by Joel Oliveira on 14/01/14.
//  Copyright (c) 2014 Joel Oliveira. All rights reserved.
//

#import "TagsCell.h"
#import "AppDelegate.h"

@implementation TagsCell

@synthesize tagSwitch = _tagSwitch;
@synthesize tagLabel = _tagLabel;


- (AppDelegate *)appDelegate {
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}



@end
