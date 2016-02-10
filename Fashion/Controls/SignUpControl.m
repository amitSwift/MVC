//
//  signUpControl.m
//  Fashion
//
//  Created by Rana on 10/12/15.
//  Copyright © 2015 lakh. All rights reserved.
//

#import "SignUpControl.h"
#import "LibOften.h"
#import "UserStore.h"

#define MsgValidateLength @"should not be blank."
#define REGEX_EMAIL @"[A-Z0-9a-z._%+-]{3,}+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"

@interface SignUpControl ()

@property (strong, nonatomic) IBOutlet UILabel *lblError;
@property (strong, nonatomic) IBOutlet UITextField *txtNickname;
@property (strong, nonatomic) IBOutlet UITextField *txtUserName;
@property (strong, nonatomic) IBOutlet UITextField *txtEmail;
@property (strong, nonatomic) IBOutlet UITextField *txtPassword;

- (IBAction)backButton:(id)sender;
- (IBAction)registerButton:(id)sender;

@end

@implementation SignUpControl

+ (instancetype)new {
    SignUpControl *control = [[UIStoryboard mainStoryboard] instantiateViewControllerWithIdentifier:@"SignUpControl"];
    return control;
}

- (IBAction)backButton:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)registerButton:(id)sender {
    [self.txtNickname resignFirstResponder];
    [self.txtUserName resignFirstResponder];
    [self.txtEmail resignFirstResponder];
    [self.txtPassword resignFirstResponder];
    self.lblError.textColor = COLOR_FASHION_PINK;
    self.lblError.text = @"";
    if (![self validate:self.txtNickname] || ![self validate:self.txtUserName] || ![self validate:self.txtEmail] || ![self validate:self.txtPassword])
        return;
    
    [SVProgressHUD show];
    [[UserStore shared] registerWithDisplayName:self.txtNickname.text userName:self.txtUserName.text email:self.txtEmail.text password:self.txtPassword.text withCompletion:^(NSError *error, User *user) {
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
                [self dismissViewControllerAnimated:YES completion:nil];
            }
        }
    }];
}

- (BOOL)validate:(UITextField *)txtField {
    [txtField resignFirstResponder];
    if ([txtField.text length] == 0) {
        self.lblError.text = [NSString stringWithFormat:@"%@ %@", txtField.placeholder, MsgValidateLength];
        [txtField becomeFirstResponder];
        return NO;
    } else if (txtField == self.txtEmail) {
        NSPredicate *regex = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", REGEX_EMAIL];
        BOOL check = [regex evaluateWithObject:txtField.text];
        if (!check) {
            self.lblError.text = @"Enter valid email.";
        }
        return check;
    } else {
        return YES;
    }
}

@end


