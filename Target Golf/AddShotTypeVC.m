//
//  ClubAndSwingDetailViewController.m
//  Target Golf
//
//  Created by Claire Wright on 17/06/2013.
//  Copyright (c) 2013 Claire Wright. All rights reserved.
//

#import "AddShotTypeVC.h"

@interface AddShotTypeVC ()

@end

@implementation AddShotTypeVC


- (void)viewDidLoad
{
    [super viewDidLoad];
	
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)saveButtonPressed:(UIBarButtonItem *)sender
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    [self.delegate addShotTypeVC:self didFinishWithSave:YES];
    
}

-(void)cancelButtonPressed:(UIBarButtonItem *)sender
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    [self.delegate addShotTypeVC:self didFinishWithSave:NO];
    
}


@end
