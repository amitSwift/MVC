//
//  loginControl.m
//  Fashion
//
//  Created by Lakhwinder Singh on 10/12/15.
//  Copyright © 2015 lakh. All rights reserved.
//

#import "LoginControl.h"
#import "LibOften.h"
#import "UserStore.h"

@interface LoginControl ()
@property (strong, nonatomic) IBOutlet UITextField *userName;
@property (strong, nonatomic) IBOutlet UITextField *password;
@property (strong, nonatomic) IBOutlet UILabel *lblError;
- (IBAction)forgetPasswordButtonClicked:(id)sender;

- (IBAction)backButton:(id)sender;
- (IBAction)loginButtonClicked:(id)sender;

@end

@implementation LoginControl

+ (instancetype)new {
    LoginControl *control = [[UIStoryboard mainStoryboard] instantiateViewControllerWithIdentifier:@"LoginControl"];
    return control;
}

- (IBAction)forgetPasswordButtonClicked:(id)sender {
    self.lblError.textColor = [UIColor whiteColor];
    self.lblError.text = @"";
    UIAlertView *alert = [UIAlertView showWithTextFieldTitle:@"Lost Password?" message:@"Please enter your username or email address. You will receive a link to create a new password via email." buttons:@[@"Cancel", @"Get New Password"] completion:^(NSUInteger buttonIndex, NSString *text) {
        if (buttonIndex == 1) {
            if (text.length) {
                [SVProgressHUD show];
                [[UserStore shared] getPasswordWithUserName:text withCompletion:^(NSError *error, NSString *msg) {
                    if (error) {
                        self.lblError.text = [error localizedDescription];
                        self.lblError.textColor = [UIColor redColor];
                        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
                    }
                    else {
                        self.lblError.text = msg;
                        [SVProgressHUD dismiss];
                    }
                }];
            }
            else {
                [self forgetPasswordButtonClicked:nil];
            }
        }
    }];
    UITextField *textField = [alert textFieldAtIndex:0];
    textField.placeholder = @"Username or E-mail";
}

- (IBAction)backButton:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)loginButtonClicked:(id)sender {
    [self.userName resignFirstResponder];
    [self.password resignFirstResponder];
    self.lblError.textColor = [UIColor whiteColor];
    self.lblError.text = @"";
    if (!self.userName.text.length) {
        self.lblError.text = @"Please enter username/email";
        [self.userName becomeFirstResponder];
    }
    else if (!self.password.text.length) {
        self.lblError.text = @"Please enter password.";
        [self.password becomeFirstResponder];
    }
    else {
        [SVProgressHUD show];
        [[UserStore shared] loginWithUserName:self.userName.text andPassword:self.password.text withCompletion:^(NSError *error, User *user) {
            if (error) {
                self.lblError.text = [error localizedDescription];
                self.lblError.textColor = [UIColor redColor];
                [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
            }
            else {
                [SVProgressHUD dismiss];
                if (!user) {
                    self.lblError.text = @"Check internet connection.\nPlease try again.";
                }
                else {
                    [UIAlertView showWithTitle:@"Alert!" message:@"Process pending after login..." buttons:@[@"Ok"] completion:^(NSUInteger index) {
                        [self dismissViewControllerAnimated:YES completion:nil];
                    }];
                }
            }
        }];
    }
}

@end


