//
//  rollViewController.h
//  SmartCamera
//
//  Created by gubrian on 3/12/14.
//  Copyright (c) 2014 gubrian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>

@interface rollViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

-(void) startRoll;
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker;
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info;

- (IBAction)roll:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@end
