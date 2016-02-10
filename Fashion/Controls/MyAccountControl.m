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
#import "PINRemoteImageAdapter.h"

@interface MyAccountControl ()
@property (strong, nonatomic) IBOutlet UILabel *loginButton;
- (IBAction)signOutButtonClicked:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *signOutButton;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UIImageView *profileImageView;
- (IBAction)profileButtonClicked:(id)sender;
@end

@implementation MyAccountControl

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initViews];
    // Do any additional setup after loading the view.
}

- (void)initViews {
    self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.height/2;
    self.profileImageView.clipsToBounds = YES;
    
    self.loginButton.text = @"You are not logged in yet!\nTap anywhere to login/signup.";
    [[UIView appearanceWhenContainedInInstancesOfClasses:@[[UITabBar class]]] setTintColor:[UIColor whiteColor]];
    DefineWeakSelf;
    self.loginButton.actionBlock = ^{
        [weakSelf presentViewController:[[UIStoryboard mainStoryboard] instantiateViewControllerWithIdentifier:@"SignInSignUpControl"] animated:YES completion:nil];
    };
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    BOOL checkLogin = [UserStore shared].isLoggedIn;
    self.loginButton.hidden = checkLogin;
    self.signOutButton.hidden = !checkLogin;

    if (checkLogin) {
        User *user = [UserStore shared].getUser;
        self.nameLabel.text = user.displayName;
        [self.profileImageView setUrl:[NSURL URLWithString:user.avatar] placeholder:[UIImage imageNamed:@"profilePicHolder"]];
    }
    else {
        self.nameLabel.text = @"Your Profile Page";
        self.profileImageView.image = [UIImage imageNamed:@"profilePicHolder"];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)signOutButtonClicked:(id)sender {
    [UIAlertView showWithTitle:@"Sign out?" message:nil buttons:@[@"Cancel", @"OK"] completion:^(NSUInteger buttonIndex){
        if (buttonIndex == 1) {
            [[UserStore shared] logoutUser];
            [self viewWillAppear:YES];
        }
    }];
}

- (IBAction)profileButtonClicked:(id)sender {
    
}

@end


