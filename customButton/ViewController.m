//
//  ViewController.m
//  customButton
//
//  Created by gisxing on 14-1-9.
//  Copyright (c) 2014年 gisxing. All rights reserved.
//

#import "ViewController.h"
#import "cardButton.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet cardButton *oneButton;

@end

@implementation ViewController


- (IBAction)hueValueChanged:(id)sender
{
    UISlider * slider = (UISlider *) sender;
    self.oneButton.hue = slider.value;
}

- (IBAction)saturationValueChanged:(id)sender
{
    UISlider * slider = (UISlider *)sender;
    self.oneButton.saturation = slider.value;
}

- (IBAction)brightnessValueChanged:(id)sender
{
    UISlider * slider = (UISlider *)sender;
    self.oneButton.brightness = slider.value;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
