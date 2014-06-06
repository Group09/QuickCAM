//
//  ViewController.h
//  PictureShare
//
//  Created by Sophia Villani on 6/2/14.
//  Copyright (c) 2014 Drexel University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Social/Social.h>

@interface ViewController : UIViewController < UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIAlertViewDelegate, UITextFieldDelegate, UITextFieldDelegate, UIActionSheetDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UITextField *textField;

@property (strong, nonatomic) SLComposeViewController *slComposeViewController;
@property (strong, nonatomic) NSData *imageToShare;
@property (weak, nonatomic) IBOutlet UILabel *text;

@end
