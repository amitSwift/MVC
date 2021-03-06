//
//  MyAccountControl.m
//  Fashion
//
//  Created by Rana on 06/12/15.
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
   // [[UIView appearanceWhenContainedInInstancesOfClasses:@[[UITabBar class]]] setTintColor:[UIColor whiteColor]];
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
        
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"ProfilePicture"] != nil)
        {
            self.profileImageView.image = [UIImage imageWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"ProfilePicture"]];
        }
        
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
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"ProfilePicture"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            self.profileImageView.image = [UIImage imageNamed:@"profilePicHolder"];
            [self viewWillAppear:YES];
        }
    }];
}

- (IBAction)profileButtonClicked:(id)sender
{
    BOOL checkLogin = [UserStore shared].isLoggedIn;
    
    if (checkLogin == YES)
    {
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"Choose Option" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Open Camera",@"Open Photos", nil];
        sheet.delegate = self;
        [sheet showInView:self.view];
    }
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex)
    {
        case 0:
        {
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
            {
                UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
                imagePicker.delegate = self;
                imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
                imagePicker.allowsEditing = YES;
                [self presentViewController:imagePicker animated:YES completion:nil];
            }
        }
            break;
            
        case 1:
        {
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.delegate = self;
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            imagePicker.allowsEditing = YES;
            [self presentViewController:imagePicker animated:YES completion:nil];
        }
            break;
            
        default:
            break;
    }
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *selectedImage = [info objectForKey:UIImagePickerControllerEditedImage];
    [picker dismissViewControllerAnimated:YES completion:^{
        self.profileImageView.image = selectedImage;
        [[NSUserDefaults standardUserDefaults] setObject:UIImageJPEGRepresentation(selectedImage, 1.0) forKey:@"ProfilePicture"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end


