//
// UIAPPicker.m
// Version 0.0.1
//
// This code is distributed under the terms and conditions of the MIT license.
//
// Copyright (c) 2014 Andrei Popescu aka proff
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//

#import "UIAPPicker.h"

@interface UIView (UIAPPicker)

@property (nonatomic) CGFloat frameY;

@property (nonatomic) CGFloat frameWidth;
@property (nonatomic) CGFloat frameHeight;

@end

@implementation UIView (UIAPPicker)

- (CGFloat)frameY {
    return self.frame.origin.y;
}

- (void)setFrameY:(CGFloat)newY {
    self.frame = CGRectMake(self.frame.origin.x, newY, self.frame.size.width, self.frame.size.height);
}

- (CGFloat)frameWidth {
    return self.frame.size.width;
}

- (void)setFrameWidth:(CGFloat)newWidth {
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, newWidth, self.frame.size.height);
}

- (CGFloat)frameHeight {
    return self.frame.size.height;
}

- (void)setFrameHeight:(CGFloat)newHeight {
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, newHeight);
}

@end

@interface UIAPPicker ()

@property (nonatomic, assign) id<UIAPPickerDelegate> delegate;
@property (nonatomic, strong) UIToolbar *toolbar;
@property (nonatomic, strong) UIView *containerView, *pickerView, *baseView, *shadowView;
@property (nonatomic, strong) UIPickerView *picker;
@property (nonatomic, strong) NSArray *pickerItems;
@property (nonatomic, strong) id selectedPickerItem;

@end

@implementation UIAPPicker

+ (instancetype)pickerForView:(UIView *)anView delegate:(id)anDelegate
{
    return [[UIAPPicker alloc] initForView:anView delegate:anDelegate];
}

- (id)initForView:(UIView *)anView delegate:(id)anDelegate
{
    if (self = [super init])
        {
        self.delegate = anDelegate;
        self.containerView = anView;
        [self arangeBaseView];
        }
    return self;
}

- (id)init
{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:@"For initialisation of UIAPPicker class must use pickerForView:delegate: instead init"
                                 userInfo:nil];
}

- (void)arangeBaseView
{
    [self.pickerView addSubview:self.toolbar];
    [self.pickerView addSubview:self.picker];
    
    [self.pickerView setFrame:CGRectMake(0, self.baseView.frameHeight, self.containerView.frameWidth, self.toolbar.frameHeight + self.picker.frameHeight)];

    
    [self.baseView addSubview:self.shadowView];
    [self.baseView addSubview:self.pickerView];
}

- (UIView *)baseView
{
    if (!_baseView) {
        _baseView = [[UIView alloc] initWithFrame:[self.containerView bounds]];
        _baseView.backgroundColor = [UIColor clearColor];
    }
    return _baseView;
}

- (UIView *)pickerView
{
    if (!_pickerView) {
        _pickerView = [[UIView alloc] init];
        _pickerView.backgroundColor = [UIColor whiteColor];
    }
    return _pickerView;
}

- (UIView *)shadowView
{
    if (!_shadowView) {
        _shadowView = [[UIView alloc] initWithFrame:self.baseView.frame];
        _shadowView.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.5];
        _shadowView.alpha = 0;
        
        UITapGestureRecognizer *tapShadow = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pickerCancel)];
        [_shadowView addGestureRecognizer:tapShadow];
    }
    return _shadowView;
}

- (UIToolbar *)toolbar
{
    if (!_toolbar) {
        _toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.containerView.frameWidth, 0)];
        _toolbar.barStyle = UIBarStyleBlackOpaque;
        [_toolbar sizeToFit];
        [_toolbar setItems:@[
                             [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(pickerCancel)],
                             [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                             [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(pickerDone)]
                             ]];
    }
    return _toolbar;
}

- (UIPickerView *)picker
{
    if (!_picker) {
        _picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, self.toolbar.frameHeight, self.containerView.frameWidth, 0)];
        _picker.showsSelectionIndicator = YES;
        _picker.delegate = self;
        
    }
    return _picker;
}

#pragma mark - methods

- (void)show:(NSArray *)anItems withSelectedRow:(NSInteger)selectedIndex
{
    self.pickerItems = anItems;
    
    if (!self.pickerItems || self.pickerItems.count <= 0)
        return;
    
    [self showPicker];
    
    [self.picker reloadComponent:0];
    [self.picker selectRow:selectedIndex inComponent:0 animated:YES];
    [self.picker.delegate pickerView:self.picker didSelectRow:selectedIndex inComponent:0];

}

#pragma mark - PickerViewDelegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView*)anPickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView*)anPickerView numberOfRowsInComponent:(NSInteger)anComponent
{
    return self.pickerItems.count;
}

- (NSString*)pickerView:(UIPickerView*)anPickerView titleForRow:(NSInteger)anRow forComponent:(NSInteger)anComponent
{
    id item = [self.pickerItems objectAtIndex:anRow];
    return [item description];
}

- (void)pickerView:(UIPickerView*)anPickerView didSelectRow:(NSInteger)anRow inComponent:(NSInteger)anComponent
{
    self.selectedPickerItem = [self.pickerItems objectAtIndex:anRow];
}

#pragma mark - Animations

- (void)showPicker
{
    [self.containerView addSubview:self.baseView];
    [UIView animateWithDuration:0.5 animations:^{
        self.shadowView.alpha = 1.0;
        self.pickerView.frameY -= self.pickerView.frameHeight;
    }];
}

- (void)hidePicker
{
    [UIView animateWithDuration:0.5 animations:^{
        self.pickerView.frameY += self.pickerView.frameHeight;
        self.shadowView.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self.baseView removeFromSuperview];
    }];
}

#pragma mark - Actions

- (void)pickerCancel
{
    [self hidePicker];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(pickerDidCancel:)]) {
        [self.delegate pickerDidCancel:self];
    }
}

- (void)pickerDone
{
    [self hidePicker];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(picker:didSelectItem:)]) {
        [self.delegate picker:self didSelectItem:self.selectedPickerItem];
    }
}

@end
