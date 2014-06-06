//
//  ViewController.m
//  PictureShare
//
//  Created by Sophia Villani on 6/2/14.
//  Copyright (c) 2014 Drexel University. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize imageView;
@synthesize textField;
@synthesize imageToShare;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    textField.delegate = self;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
        imagePicker.delegate = self;
        [imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
        [self presentViewController:imagePicker animated:YES completion:NULL];
    }
}
- (IBAction)camera:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"QuickCam" message:nil delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:@"Take a Photo",@"Choose Existing", nil];
    
    alert.alertViewStyle = UIAlertViewStyleDefault;
    
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1 && [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
        imagePicker.delegate = self;
        [imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
        [self presentViewController:imagePicker animated:YES completion:NULL];
        
    }
    if (buttonIndex == 2) {
        UIImagePickerController *imagePicker2 = [[UIImagePickerController alloc]init];
        imagePicker2.delegate = self;
        [self presentViewController:imagePicker2 animated:YES completion:NULL];
    }
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, @"QuickCam");
    imageToShare = UIImageJPEGRepresentation(image, 1.0);
    [imageView setImage:image];
    [self dismissViewControllerAnimated:YES completion:NULL];
}


-(IBAction)share:(id)sender{
    UIActionSheet *share = [[UIActionSheet alloc]initWithTitle:@"Share!" delegate:self cancelButtonTitle:@"Dismiss" destructiveButtonTitle:nil otherButtonTitles:@"Facebook", @"Twitter", nil];
    
    [share showInView:self.view];
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    NSString *tempString = [NSString stringWithFormat:@"%@", textField.text];
    
    if (buttonIndex == 0) {
        if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]){
            self.slComposeViewController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
            [self.slComposeViewController addImage:[UIImage imageWithData:imageToShare]];
            [self.slComposeViewController setInitialText:tempString];
            [self presentViewController:self.slComposeViewController animated:YES completion:NULL];
        }else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Account Found" message:@"Make sure you have a facebook account connected" delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    if (buttonIndex == 1){
        if([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]){
            self.slComposeViewController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
            [self.slComposeViewController addImage:[UIImage imageWithData:imageToShare]];
            [self.slComposeViewController setInitialText:tempString];
            [self presentViewController:self.slComposeViewController animated:YES completion:NULL];
        }else {
            UIAlertView *alert1 = [[UIAlertView alloc] initWithTitle:@"No Account Found" message:@"Make sure you have a twitter account connected" delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil, nil];
            [alert1 show];
        }
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [textField resignFirstResponder];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (self.textField){
        [self.textField resignFirstResponder];
    }
    return NO;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.2];
    [UIView setAnimationBeginsFromCurrentState:YES];
    self.view.frame = CGRectMake(self.view.frame.origin.x, (self.view.frame.origin.y - 160.0), self.view.frame.size.width, self.view.frame.size.height);
    [UIView commitAnimations];
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.2];
    [UIView setAnimationBeginsFromCurrentState:YES];
    self.view.frame = CGRectMake(self.view.frame.origin.x, (self.view.frame.origin.y + 160.0), self.view.frame.size.width, self.view.frame.size.height);
    [UIView commitAnimations];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
