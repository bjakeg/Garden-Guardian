//
//  PurchasesViewController.m
//  GardenGuardian
//
//  Created by Jake Graham on 3/15/17.
//  Copyright © 2017 BACKENDLESS.COM. All rights reserved.
//

#import "PurchasesViewController.h"
#import "MMDrawerBarButtonItem.h"
#import "UIViewController+MMDrawerController.h"

@interface PurchasesViewController ()

@end

@implementation PurchasesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self setTitle:@"Purchases"];
    
    [self setupLeftMenuButton];
    
    UIButton *veggiesButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 100, 150, 150)];
    [veggiesButton setImage:[UIImage imageNamed:@"cucumber_ic.png"] forState:UIControlStateNormal];
    [veggiesButton addTarget:self action:@selector(veggiesButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [[veggiesButton layer] setBorderWidth:2.0f];
    [[veggiesButton layer] setBorderColor:[UIColor greenColor].CGColor];
    [self.view addSubview:veggiesButton];
    
    UILabel *veggiesLabel = [[UILabel alloc] init];
    veggiesLabel.text = @"Veggies Guide";
    [veggiesLabel sizeToFit];
    CGRect frame = veggiesLabel.frame;
    frame = CGRectMake(20 + veggiesButton.frame.size.width/2 - frame.size.width/2,
                       260,
                       frame.size.width,
                       frame.size.height);
    veggiesLabel.frame = frame;
    [self.view addSubview:veggiesLabel];
    
    UILabel *veggiePrice = [[UILabel alloc] init];
    veggiePrice.text = @"$2.99";
    [veggiePrice sizeToFit];
    frame = veggiePrice.frame;
    frame = CGRectMake(20 + veggiesButton.frame.size.width/2 - frame.size.width/2,
                       280,
                       frame.size.width,
                       frame.size.height);
    veggiePrice.frame = frame;
    veggiePrice.textColor = [UIColor blueColor];
    [self.view addSubview:veggiePrice];
    
    
    
    UIButton *fruitButton =
        [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 150 - 20, 100, 150, 150)];
    [fruitButton setImage:[UIImage imageNamed:@"grapes_ic.png"] forState:UIControlStateNormal];
    [fruitButton addTarget:self action:@selector(fruitButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [[fruitButton layer] setBorderWidth:2.0f];
    [[fruitButton layer] setBorderColor:[UIColor blackColor].CGColor];
    [fruitButton setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:fruitButton];
    
    UILabel *fruitLabel = [[UILabel alloc] init];
    fruitLabel.text = @"Fruit Guide";
    [fruitLabel sizeToFit];
    frame = fruitLabel.frame;
    frame = CGRectMake(fruitButton.frame.origin.x + fruitButton.frame.size.width/2 - frame.size.width/2,
                       260,
                       frame.size.width,
                       frame.size.height);
    fruitLabel.frame = frame;
    [self.view addSubview:fruitLabel];
    
    UILabel *fruitPrice = [[UILabel alloc] init];
    fruitPrice.text = @"$2.99";
    [fruitPrice sizeToFit];
    frame = veggiePrice.frame;
    frame = CGRectMake(fruitButton.frame.origin.x + fruitButton.frame.size.width/2 - frame.size.width/2,
                       280,
                       frame.size.width,
                       frame.size.height);
    fruitPrice.frame = frame;
    fruitPrice.textColor = [UIColor blueColor];
    [self.view addSubview:fruitPrice];
    
    
    
    UIButton *flowersButton =
        [[UIButton alloc] initWithFrame:CGRectMake(20, self.view.frame.size.height - 150 - 150, 150, 150)];
    [flowersButton setImage:[UIImage imageNamed:@"flower_ic2.png"] forState:UIControlStateNormal];
    [flowersButton addTarget:self action:@selector(flowersButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [[flowersButton layer] setBorderWidth:2.0f];
    [[flowersButton layer] setBorderColor:[UIColor greenColor].CGColor];
    [flowersButton setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:flowersButton];
    
    UILabel *flowersLabel = [[UILabel alloc] init];
    flowersLabel.text = @"Flower Guide";
    [flowersLabel sizeToFit];
    frame = flowersLabel.frame;
    frame = CGRectMake(flowersButton.frame.origin.x + flowersButton.frame.size.width/2 - frame.size.width/2,
                       flowersButton.frame.origin.y + 160,
                       frame.size.width,
                       frame.size.height);
    flowersLabel.frame = frame;
    [self.view addSubview:flowersLabel];
    
    UILabel *flowersPrice = [[UILabel alloc] init];
    flowersPrice.text = @"$2.99";
    [flowersPrice sizeToFit];
    frame = flowersPrice.frame;
    frame = CGRectMake(flowersButton.frame.origin.x + flowersButton.frame.size.width/2 - frame.size.width/2,
                       flowersButton.frame.origin.y + 180,
                       frame.size.width,
                       frame.size.height);
    flowersPrice.frame = frame;
    flowersPrice.textColor = [UIColor blueColor];
    [self.view addSubview:flowersPrice];
    
    
    UIButton *cloudButton =
        [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 150 - 20, self.view.frame.size.height - 150 - 150, 150, 150)];
    UIImage *image = [[UIImage imageNamed:@"cloud_ic"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [cloudButton setImage:image forState:UIControlStateNormal];
    [cloudButton setTintColor:[UIColor lightGrayColor]];
    [cloudButton addTarget:self action:@selector(cloudButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [[cloudButton layer] setBorderWidth:2.0f];
    [[cloudButton layer] setBorderColor:[UIColor greenColor].CGColor];
    [self.view addSubview:cloudButton];
    
    UILabel *cloudLabel = [[UILabel alloc] init];
    cloudLabel.text = @"Cloud Service";
    [cloudLabel sizeToFit];
    frame = cloudLabel.frame;
    frame = CGRectMake(cloudButton.frame.origin.x + cloudButton.frame.size.width/2 - frame.size.width/2,
                       cloudButton.frame.origin.y + 160,
                       frame.size.width,
                       frame.size.height);
    cloudLabel.frame = frame;
    [self.view addSubview:cloudLabel];
    
    UILabel *cloudPrice = [[UILabel alloc] init];
    cloudPrice.text = @"$2.99/month";
    [cloudPrice sizeToFit];
    frame = cloudPrice.frame;
    frame = CGRectMake(cloudButton.frame.origin.x + cloudButton.frame.size.width/2 - frame.size.width/2,
                       cloudButton.frame.origin.y + 180,
                       frame.size.width,
                       frame.size.height);
    cloudPrice.frame = frame;
    cloudPrice.textColor = [UIColor blueColor];
    [self.view addSubview:cloudPrice];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupLeftMenuButton{
    MMDrawerBarButtonItem * leftDrawerButton = [[MMDrawerBarButtonItem alloc] initWithTarget:self action:@selector(leftDrawerButtonPress:)];
    [self.navigationItem setLeftBarButtonItem:leftDrawerButton animated:YES];
}

-(void)leftDrawerButtonPress:(id)sender{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

- (void)veggiesButtonPressed {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Notice"
                                                    message:@"Veggie Guide already purchased."
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

- (void)flowersButtonPressed {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Notice"
                                                    message:@"Flower Guide already purchased."
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

- (void)fruitButtonPressed {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Purchase"
                                                    message:@"Are you sure you want to buy Fruit Guide for $2.99?"
                                                   delegate:self
                                          cancelButtonTitle:@"Cancel"
                                          otherButtonTitles:@"Yes", nil];
    [alert show];
}

- (void)cloudButtonPressed {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Notice"
                                                    message:@"You are currently subscribed to Garden Guardian cloud service. You can unsubscribe through the app store."
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if ([alertView.title isEqualToString:@"Purchase"]) {
        if (buttonIndex == 1) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Enter Password"
                                                            message:@"Apple ID: bjakeg@gmail.com"
                                                           delegate:self
                                                  cancelButtonTitle:@"Cancel"
                                                  otherButtonTitles:@"OK", nil];
            alert.alertViewStyle = UIAlertViewStyleSecureTextInput;
            [alert show];
        }
    }
}

@end
