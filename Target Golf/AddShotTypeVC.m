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
    
    self.navigationController.navigationBarHidden = NO;
  
	
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)saveButtonPressed:(UIBarButtonItem *)sender
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    self.shotType.club = self.clubLabel.text;
    self.shotType.length = self.lengthLabel.text;
    
    [self.navigationController popViewControllerAnimated:YES];
    [self.delegate addShotTypeVC:self didFinishWithSave:YES];
    
    
}

- (IBAction)cancelButtonPressed:(UIBarButtonItem *)sender;
{
    
    // TODO: What happens if i start making club then change my mind?? delete the entity?
    NSLog(@"%s", __PRETTY_FUNCTION__);
    [self.navigationController popViewControllerAnimated:YES];
}

@end
