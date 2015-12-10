//
//  MyAccountControl.m
//  Fashion
//
//  Created by Lakhwinder Singh on 06/12/15.
//  Copyright © 2015 lakh. All rights reserved.
//

#import "MyAccountControl.h"
#import "LibOften.h"
#import "UserStore.h"

@interface MyAccountControl ()
@property (strong, nonatomic) IBOutlet UILabel *loginButton;
@end

@implementation MyAccountControl

- (void)viewDidLoad {
    [super viewDidLoad];
    [[UIView appearanceWhenContainedInInstancesOfClasses:@[[UITabBar class]]] setTintColor:[UIColor whiteColor]];
    
    self.loginButton.hidden = [UserStore shared].isLoggedIn;
    self.loginButton.text = @"You are not logged in yet!\nTap anywhere to login/signup";
    
    DefineWeakSelf;
    self.loginButton.actionBlock = ^{
        [weakSelf presentViewController:[[UIStoryboard mainStoryboard] instantiateViewControllerWithIdentifier:@"SignInSignUpControl"] animated:YES completion:nil];
    };
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end


