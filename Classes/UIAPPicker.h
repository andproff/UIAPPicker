//
// UIAPPicker.h
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

#import <Foundation/Foundation.h>

@protocol UIAPPickerDelegate;

@interface UIAPPicker : NSObject<UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, assign) id<UIAPPickerDelegate> delegate;
@property (nonatomic, strong) UIToolbar *toolbar;
@property (nonatomic, strong) UIView *containerView, *pickerView, *baseView, *shadowView;
@property (nonatomic, strong) UIPickerView *picker;
@property (nonatomic, strong) NSArray *pickerItems;
@property (nonatomic, strong) id selectedPickerItem;

+ (instancetype)pickerForView:(UIView *)anView delegate:(id)anDelegate;
- (void)show:(NSArray *)anItems withSelectedRow:(NSInteger)selected;

@end

@protocol UIAPPickerDelegate <NSObject>
@optional
- (void)picker:(UIAPPicker *)anPicker didSelectItem:(id)anItem;
- (void)pickerDidCancel:(UIAPPicker *)anPicker;
@end
