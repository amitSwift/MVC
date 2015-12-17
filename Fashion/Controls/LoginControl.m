//
//  loginControl.m
//  Fashion
//
//  Created by Lakhwinder Singh on 10/12/15.
//  Copyright © 2015 lakh. All rights reserved.
//

#import "LoginControl.h"
#import "LibOften.h"

@interface LoginControl ()

- (IBAction)backButton:(id)sender;

@end

@implementation LoginControl

+ (instancetype)new {
    LoginControl *control = [[UIStoryboard mainStoryboard] instantiateViewControllerWithIdentifier:@"LoginControl"];
    return control;
}

- (IBAction)backButton:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end


