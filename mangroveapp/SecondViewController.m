//
//  SecondViewController.m
//  mangroveapp
//
//  Created by Joel Oliveira on 12/01/14.
//  Copyright (c) 2014 Joel Oliveira. All rights reserved.
//

#import "SecondViewController.h"
#import "AppDelegate.h"
#import "TagsCell.h"

@interface SecondViewController ()

@end

@implementation SecondViewController


- (AppDelegate *)appDelegate {
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    
    //The UINavigationItem is neede as a "box" that holds the Buttons or other elements
    UINavigationItem *buttonCarrier = [[UINavigationItem alloc] initWithTitle:LSSTRING(@"settings")];
    
//    //Creating some buttons:
//    UIBarButtonItem *barBackButton = [[UIBarButtonItem alloc] initWithTitle:LSSTRING(@"add") style:UIBarButtonItemStyleDone target:self action:@selector(addTag)];
//    
//    //Putting the Buttons on the Carrier
//    [buttonCarrier setRightBarButtonItem:barBackButton];
//
//    
//    //The NavigationBar accepts those "Carrier" (UINavigationItem) inside an Array
    NSArray *barItemArray = [[NSArray alloc]initWithObjects:buttonCarrier,nil];
    
    // Attaching the Array to the NavigationBar
    [[self navigationBar] setItems:barItemArray];
    
    //Check if everything is correct in the plist
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"tags" ofType:@"plist"];
    NSDictionary *pfile = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    
    NSMutableDictionary * definedTags = [NSMutableDictionary dictionaryWithDictionary:pfile];
    NSMutableArray * theTags = [NSMutableArray array];
    
    for (NSString * definedTag in [definedTags objectForKey:@"tags"]) {
        [theTags addObject:definedTag];
    }
    
    
    [self setTags:theTags];
    [self setTmpLog:[NSMutableArray array]];
    [[self tblView] reloadData];
    
    [[self appDelegate] getTags];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadList) name:@"gotTags" object:nil];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    

    return [[self tags] count];

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return DEFAULT_CELLHEIGHT;
    
}

-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return DEFAULT_HEADER_HEIGHT;
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    return @"Tags";
}

-(void) reloadList{
    [[self tblView] reloadData];
}



// Create the cells
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"tags" ofType:@"plist"];
    NSDictionary *pfile = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    NSMutableDictionary * definedTags = [NSMutableDictionary dictionaryWithDictionary:pfile];

    
    NSMutableDictionary * log = [NSMutableDictionary dictionary];
    
    static NSString *CellIdentifier = @"TagsCell";
    
    TagsCell *cell = [tableView
                              dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[TagsCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    cell.tagLabel.text = LSSTRING([[self tags] objectAtIndex:indexPath.row]);


    for (NSString * tagFromServer in [[self appDelegate] tags]) {
 
        if([[[definedTags objectForKey:@"tags"] objectForKey:[[self tags] objectAtIndex:indexPath.row]] isEqual:tagFromServer]){
            [[cell tagSwitch] setOn:YES];
        }
        
    }
    
    UISwitch * switchTag = [(TagsCell *)cell tagSwitch];
    [switchTag addTarget:self action:@selector(changeTag:) forControlEvents:UIControlEventValueChanged];
    
    [log setObject:switchTag forKey:[[self tags] objectAtIndex:indexPath.row]];
    [[self tmpLog] addObject:log];
    
    return cell;
    
}

-(void)changeTag:(id)sender {

    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"tags" ofType:@"plist"];
    NSDictionary *pfile = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    NSMutableDictionary * definedTags = [NSMutableDictionary dictionaryWithDictionary:pfile];
    
    UISwitch *tempSwitch = (UISwitch *)sender;
    
    if([tempSwitch isOn]){

        //add tag
        for (NSDictionary * log in [self tmpLog]) {
            
            NSArray * keys = [log allKeysForObject:tempSwitch];

            for (NSString * tagKey in keys) {

                [[self appDelegate] createTags:@[[[definedTags objectForKey:@"tags"] objectForKey:tagKey]]];
            }
        }
    }else{
        //delete tag

        for (NSDictionary * log in [self tmpLog]) {
            
            NSArray * keys = [log allKeysForObject:tempSwitch];
            
            for (NSString * tagKey in keys) {
                
                [[self appDelegate] deleteTag:[[definedTags objectForKey:@"tags"] objectForKey:tagKey]];

            }
        }
    }
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
