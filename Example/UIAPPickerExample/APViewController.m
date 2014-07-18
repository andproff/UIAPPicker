//
//  APViewController.m
//  UIAPPickerExample
//
//  Created by Andrei Popescu on 7/18/14.
//  Copyright (c) 2014 Andrei Popescu. All rights reserved.
//

#import "APViewController.h"
#import "UIAPPicker.h"

#define kAnArray @[@"Moscow", @"New York",  @"Paris", @"Berlin", @"Ankara"]

@interface APViewController ()

@property (strong, nonatomic) UIAPPicker *apPicker;
@property (strong, nonatomic) IBOutlet UILabel *itemLabel;

@end

@implementation APViewController

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

- (IBAction)showPickerTouchUp:(id)sender
{
    [self.apPicker show:kAnArray withSelectedRow:[kAnArray indexOfObject:self.itemLabel.text]];
}

- (UIAPPicker *)apPicker
{
    if (!_apPicker) {
        _apPicker = [UIAPPicker pickerForView:self.view delegate:self];
    }
    return _apPicker;
}

#pragma mark - UIAPPickerDelegate

- (void)pickerDidCancel:(UIAPPicker *)anPicker
{
    
}

- (void)picker:(UIAPPicker *)anPicker didSelectItem:(id)anItem
{
    self.itemLabel.text = anItem;
}

@end
