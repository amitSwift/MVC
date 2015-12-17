//
//  loginSignUpControl.m
//  Fashion
//
//  Created by Lakhwinder Singh on 10/12/15.
//  Copyright © 2015 lakh. All rights reserved.
//

#import "LoginSignUpControl.h"
#import "LoginControl.h"
#import "SignUpControl.h"

@interface LoginSignUpControl ()

- (IBAction)closeButton:(id)sender;
- (IBAction)loginButton:(id)sender;
- (IBAction)signUpButton:(id)sender;

@end

@implementation LoginSignUpControl

- (IBAction)closeButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)loginButton:(id)sender {
    [self.navigationController pushViewController:[LoginControl new] animated:YES];
}

- (IBAction)signUpButton:(id)sender {
    [self.navigationController pushViewController:[SignUpControl new] animated:YES];
}

@end


