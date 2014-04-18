//
//  ViewController.h
//  CameraDemo
//
//  Created by apple on 14-4-1.
//  Copyright (c) 2014年 Taagoo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "PhotoViewController.h"
@interface ViewController : UIViewController <UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIAlertViewDelegate>
{
    IBOutlet UIView *MenuView;
    IBOutlet UIView *ButtonView;
    
    UIImagePickerController *picker;
    AVCaptureSession *AVSession;
    
    int CameraFlashMode;
    BOOL panorama;//是否全景
}

@property (strong, nonatomic) IBOutlet UIButton *CameraMode;
@property (strong, nonatomic) IBOutlet UIButton *CameraDevice;
@property (strong, nonatomic) IBOutlet UIButton *CameraFlash;
@property (strong, nonatomic) IBOutlet UIButton *CameraSet;

- (IBAction)PlayCamera:(id)sender;
- (IBAction)ChangeModeCamera:(id)sender;
- (IBAction)DeviceCamera:(id)sender;
- (IBAction)FlashCamera:(id)sender;
- (IBAction)SetCamera:(id)sender;

- (IBAction)CancelCamera:(id)sender;


@end
