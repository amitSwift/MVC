//
//  signUpControl.m
//  Fashion
//
//  Created by Lakhwinder Singh on 10/12/15.
//  Copyright © 2015 lakh. All rights reserved.
//

#import "SignUpControl.h"
#import "LibOften.h"

@interface SignUpControl ()

- (IBAction)backButton:(id)sender;

@end

@implementation SignUpControl

+ (instancetype)new {
    SignUpControl *control = [[UIStoryboard mainStoryboard] instantiateViewControllerWithIdentifier:@"SignUpControl"];
    return control;
}

- (IBAction)backButton:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end


