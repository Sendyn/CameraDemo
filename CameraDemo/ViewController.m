//
//  ViewController.m
//  CameraDemo
//
//  Created by apple on 14-4-1.
//  Copyright (c) 2014年 Taagoo. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    UIImageView *imageView;
}
@end

@implementation ViewController
@synthesize CameraFlash,CameraDevice,CameraMode,CameraSet;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    picker = [[UIImagePickerController alloc]init];
    
    imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 568)];
    imageView.userInteractionEnabled = YES;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removeImageView:)];
    [imageView addGestureRecognizer:singleTap];
}

-(void)removeImageView:(UITapGestureRecognizer *)recognizer
{
    [imageView removeFromSuperview];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//调用相机
- (IBAction)PlayCamera:(id)sender {
    
    CameraFlashMode = 0;

    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] ) {
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.delegate = self;
        picker.allowsEditing = YES;
        [self presentViewController:picker animated:YES completion:nil];
    } else {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"没有可用的摄像头" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
    
    picker.cameraFlashMode = UIImagePickerControllerCameraFlashModeAuto;
    picker.cameraOverlayView = MenuView;
    picker.showsCameraControls = NO;

}

- (IBAction)ChangeModeCamera:(id)sender {
    [picker takePicture];
}


//闪光灯
- (IBAction)FlashCamera:(id)sender {
    if (CameraFlashMode == 0) {
        picker.cameraFlashMode = UIImagePickerControllerCameraFlashModeOn;
        [CameraFlash setImage:[UIImage imageNamed:@"camera_flash_on"] forState:UIControlStateNormal];
        CameraFlashMode = 1;
    } else if (CameraFlashMode == 1) {
        picker.cameraFlashMode = UIImagePickerControllerCameraFlashModeOff;
        [CameraFlash setImage:[UIImage imageNamed:@"camera_flash_off"] forState:UIControlStateNormal];
        CameraFlashMode = 2;
    }else if (CameraFlashMode == 2) {
        picker.cameraFlashMode = UIImagePickerControllerCameraFlashModeAuto;
        [CameraFlash setImage:[UIImage imageNamed:@"camera_flash_auto"] forState:UIControlStateNormal];
        CameraFlashMode = 0;
    }
}


//摄像头转换
- (IBAction)DeviceCamera:(id)sender {
    if (picker.cameraDevice == UIImagePickerControllerCameraDeviceFront) {
        picker.cameraDevice = UIImagePickerControllerCameraDeviceRear;
    } else {
        picker.cameraDevice = UIImagePickerControllerCameraDeviceFront;
    }
}

//拍照设置
- (IBAction)SetCamera:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"拍照模式" message:@"是否开启全景拍照" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"NO", nil];
    [alert show];
}

- (IBAction)CancelCamera:(id)sender {
    [self imagePickerControllerDidCancel:picker];
}


#pragma mark UIImagePickerControllerDelegate method

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    
    [self dismissViewControllerAnimated:YES completion:^{
        [self.view addSubview:imageView];
        imageView.image = image;
    }];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark UIAlertViewDelegate Method

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
{
    switch (buttonIndex) {
        case 0:
            panorama = YES;
            break;
        case 1:
            panorama = NO;
            break;
        default:
            break;
    }
    NSLog(@"%d",panorama);
}
@end
