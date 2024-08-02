UIAPPicker
==========

The UIAPPicker is simple way to show custom UIPicker in selected view without using UIActionSheet.

### Installation with CocoaPods
This project support installations with CocoaPods

#### Podfile
```ruby
platform :ios, '6.1'
pod "UIAPPicker"
```

#### Picker initialization 
```objective-c
@property (strong, nonatomic) UIAPPicker *apPicker;

- (UIAPPicker *)apPicker
{
    if (!_apPicker) {
        _apPicker = [UIAPPicker pickerForView:self.view delegate:self];
    }
    return _apPicker;
}
```

#### Show Picker
```objective-c
[self.apPicker show:@[@"Moscow", @"New York",  @"Paris", @"Berlin", @"Ankara"] withSelectedRow:0];
```

#### UIAPPickerDelegate
```objective-c
@protocol UIAPPickerDelegate
- (void)pickerDidCancel:(UIAPPicker *)anPicker;
- (void)picker:(UIAPPicker *)anPicker didSelectItem:(id)anItem;
@end
```

## License
UIAPPicker is available under the [MIT](https://github.com/andproff/UIAPPicker#MIT-1-ov-file) license. See the LICENSE file for more info.
